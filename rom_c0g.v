module rom_c0g(
	input [6:0] addr_a,
	input [6:0] addr_b,
	output [18:0] c0g_a,
	output [18:0] c0g_b
);

reg [19:0] mem [0:127];

assign c0g_a = mem[addr_a];
assign c0g_b = mem[addr_b];

initial begin
	$readmemb("c0g.list", mem); 
end

endmodule
