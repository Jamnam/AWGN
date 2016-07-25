module lzd2(
	input [1:0] a,
	output p,
	output v);

assign p = ~a[1] & a[0];
assign v = a[1] | a[0];

endmodule
