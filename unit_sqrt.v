module unit_sqrt(
	input [30:0] e,
	output [16:0] f 
);

wire [4:0] sb; //The number of bits need to be shifted;
wire [5:0] compsb; //The complementary form of sb;

wire [5:0] exp_f;
wire [4:0] exp_ff;
wire [30:0] x_f;
wire [5:0] x_f_A;
wire [18:0] x_f_B;

wire [29:0] prod; //The product of c1 and x_e_B;
wire [19:0] y_f;
wire [22:0] ff;

wire [10:0] c10,c11,c1;
wire [19:0] c00,c01,c0;

//DUT mapping
rom_c1f0 rom1(
	.addr(x_f_A),
	.c1f0(c10)
);

rom_c0f0 rom2(
	.addr(x_f_A),
	.c0f0(c00)
);

rom_c1f1 rom3(
	.addr(x_f_A),
	.c1f1(c11)
);

rom_c0f1 rom4(
	.addr(x_f_A),
	.c0f1(c01)
);

lzd32 m0(
	.a({1'b0,e}),
	.p(sb)
);


shiftere m1(
	.e(e),
	.exp_f(exp_f),
	.x_f1(x_f)
);


shiftery_f m2(
	.y_f(y_f),
	.exp_ff(exp_ff),
	.ff(ff)
);


assign c1 = (exp_f[0])?c10:c11;
assign c0 = (exp_f[0])?c00:c01;

assign compsb = ~{1'b0,sb}+1;

//sb is substract by 6 becuase the lzd used here is 32bits 
//instead of 31bits.
assign exp_f = 6 + compsb; 

assign x_f_A = x_f[24:19];
assign x_f_B = x_f[18:0];

assign prod = c1*x_f_B;
assign y_f =(exp_f[0])?prod[29:18]+c0:prod[29:17]+c0;

assign exp_ff = (exp_f[0])?exp_f+1>>1:exp_f>>1; 
assign f = ff[22:6];

endmodule




