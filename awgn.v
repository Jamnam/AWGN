`timescale 1ns / 1ps
module awgn(
	input clk,
	input rst,
	input [31:0] urng_seed1,
	input [31:0] urng_seed2,
	input [31:0] urng_seed3,
	input [31:0] urng_seed4,
	input [31:0] urng_seed5,
	input [31:0] urng_seed6,
	output reg[15:0] awgn_out
);

wire [31:0] a,b;
wire [47:0] u0;
wire [15:0] u1;
wire [30:0] e;
wire [16:0] f;
wire [15:0] g0;
wire [32:0] fg; //Product of f and g0;
wire sign;  //The MSB(Sign bit)of output;
wire [15:0] fg_s; //The compementary form of fg and shifted to the same bit as output;

//DUT mapping
urng m1(
	.seed0(urng_seed1),
	.seed1(urng_seed2),
	.seed2(urng_seed3),
	.clk(clk),
	.rst(rst),
	.rnd(a)
);

urng m2(
	.seed0(urng_seed4),
	.seed1(urng_seed5),
	.seed2(urng_seed6),
	.clk(clk),
	.rst(rst),
	.rnd(b)
);

unit_log m3(
	.u0(u0),
	.e(e)
);

unit_cos m4(
	.clk(clk),
	.rst(rst),
	.u1(u1),
	.g0(g0),
	.sign(sign)
);

unit_sqrt m5(
	.e(e),
	.f(f)
);


assign u0 = {a,b[31:16]};
assign u1 = b[15:0];
assign fg = f*g0;
assign fg_s = ~fg[32:17]+1;

//Output the sample at the rising edge of clk
always @(posedge clk or posedge rst) begin
	if (rst) awgn_out <= 0;
	else awgn_out <= (sign)?fg_s:fg[32:17];
end


endmodule
