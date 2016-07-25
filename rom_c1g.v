module rom_c1g(
	input [6:0] addr_a,
	input [6:0] addr_b,
	output [11:0] c1g_a,
	output [11:0] c1g_b
);

reg [11:0] mem [0:127];

assign c1g_a = mem[addr_a];
assign c1g_b = mem[addr_b];

initial begin
	$readmemb("c1g.list", mem); 
end


endmodule
