module lzd4(
	input [3:0] a,
	output [1:0] p,
	output v);

wire p1, v1, p0, v0, s;

lzd2 u0(
	.a(a[1:0]),
	.p(p0),
	.v(v0)
);

lzd2 u1(
	.a(a[3:2]),
	.p(p1),
	.v(v1)
);

assign s = (v1)?p1:p0;
assign p = {~v1,s};
assign v = v1 | v0;

endmodule
