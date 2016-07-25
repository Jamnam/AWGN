module rom_c1e(
	input [7:0] addr,
	output [21:0] c1e
);

reg [21:0] mem [0:255];

assign c1e = mem[addr];


initial begin
	$readmemb("c1e.list", mem); 
end


endmodule
