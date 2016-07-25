module rom_c1f1(
	input [5:0] addr,
	output [10:0] c1f1
);

reg [10:0] mem [0:63];

assign c1f1= mem[addr];

initial begin
	$readmemb("c1f1.list", mem); 
end


endmodule
