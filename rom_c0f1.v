module rom_c0f1(
	input [5:0] addr,
	output [19:0] c0f1
);

reg [19:0] mem [0:63];

assign c0f1 = mem[addr];

initial begin
	$readmemb("c0f1.list", mem); 
end


endmodule
