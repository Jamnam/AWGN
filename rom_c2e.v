module rom_c2e(
	input [7:0] addr,
	output [12:0] c2e
);

reg [12:0] mem [0:255];

assign c2e = mem[addr];


initial begin
	$readmemb("c2e.list", mem); 
end


endmodule
