module unit_log(
	input [47:0] u0,
	output [30:0] e
);

wire [5:0] exp_e;
wire [5:0] sb; //Number of bits should be shift
wire [47:0] x_e;
wire [29:0] y_e;
wire [37:0] e1;
wire [37:0] compy_e; //The complementary form of e
wire [37:0] diff_e; //The difference between e1 and y_e;

wire [7:0] x_e_A;
wire [39:0] x_e_B;

wire [79:0] sqr_B; //The square of x_e_B;
wire [52:0] prod2; //The product of sqr_B and c2e;
wire [61:0] prod1; //The produce of x_e_B and c1e;
wire [29:0] comp2; //The complementary form of c2e*x^2;
wire [12:0] c2;  
wire [21:0] c1;
wire [29:0] c0;

parameter ln2 = 32'b1011_0001_0111_0010_0001_0111_1111_0111;

//DUT mapping
shifteru0 m0(
	.u0(u0),
	.exp_e(exp_e),
	.x_e(x_e)
);

lzd48 m1(
	.a(u0),
	.p(sb)
);

rom_c2e rom2(
	.addr(x_e_A),
	.c2e(c2)
);

rom_c1e rom1(
	.addr(x_e_A),
	.c1e(c1)
);

rom_c0e rom0(
	.addr(x_e_A),
	.c0e(c0)
);

assign exp_e = sb +1;
assign x_e_A = x_e[47:40];
assign x_e_B = x_e[39:0];

assign sqr_B = x_e_B*x_e_B;
assign prod2 = c2*sqr_B[79:40];
assign comp2 = ~{17'b0_0000_0000_0000_0000,prod2[52:40]}+1; 

assign prod1 = c1*x_e_B;

assign y_e = comp2+{8'b0000_0000,prod1[61:40]}+c0;

assign e1 = exp_e * ln2;

assign compy_e = ~{6'b00_0000,y_e,2'b00}+1;
assign diff_e = e1 + compy_e;
assign e = (u0)?diff_e[37:7]:0; //e is 0 when u0 equals 0;

endmodule
