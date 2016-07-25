module rom_c0f0(
	input [5:0] addr,
	output [19:0] c0f0
);

reg [19:0] mem [0:63];

assign c0f0 = mem[addr];

initial begin
	$readmemb("c0f0.list", mem); 
end


endmodule
