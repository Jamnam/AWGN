module lzd32(
	input [31:0] a,
	output [4:0] p,
	output v);

wire v1, v0;
wire [3:0] p1, p0, s;

lzd16 u0(
	.a(a[15:0]),
	.p(p0),
	.v(v0)
);

lzd16 u1(
	.a(a[31:16]),
	.p(p1),
	.v(v1)
);

assign s = (v1)?p1:p0;
assign p = {~v1,s};
assign v = v1 | v0;

endmodule
