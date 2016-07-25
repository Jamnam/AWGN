module lzd8(
	input [7:0] a,
	output [2:0] p,
	output v);

wire v1, v0;
wire [1:0] p1, p0, s;

lzd4 u0(
	.a(a[3:0]),
	.p(p0),
	.v(v0)
);

lzd4 u1(
	.a(a[7:4]),
	.p(p1),
	.v(v1)
);

assign s = (v1)?p1:p0;
assign p = {~v1,s};
assign v = v1 | v0;

endmodule
