module rom_c1f0(
	input [5:0] addr,
	output [10:0] c1f0
);

reg [10:0] mem [0:63];

assign c1f0 = mem[addr];

initial begin
	$readmemb("c1f0.list", mem); 
end


endmodule
