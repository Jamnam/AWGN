module lzd48(
	input [47:0] a,
	output [5:0] p,
	output v);

wire v1, v0;
wire [4:0] p0,s;
wire [3:0] p1;

lzd32 u0(
	.a(a[31:0]),
	.p(p0),
	.v(v0)
);

lzd16 u1(
	.a(a[47:32]),
	.p(p1),
	.v(v1)
);

assign s = (v1)?p1:{1'b0,p0[3:0]};
assign p = (v1)?{~v1,s}:(p0[4]?{~v1,s}:{1'b0,~v1,s[3:0]});
assign v = v1 | v0;

endmodule
