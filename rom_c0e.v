module rom_c0e(
	input [7:0] addr,
	output [29:0] c0e
);

reg [29:0] mem [0:255];

assign c0e = mem[addr];


initial begin
	$readmemb("c0e.list", mem); 
end


endmodule
