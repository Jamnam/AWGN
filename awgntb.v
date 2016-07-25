`timescale 1ns / 1ps
module awgntb;

// Inputs
reg clk;
reg rst;
reg [31:0] urng_seed1;
reg [31:0] urng_seed2;
reg [31:0] urng_seed3;
reg [31:0] urng_seed4;
reg [31:0] urng_seed5;
reg [31:0] urng_seed6;

// Outputs
wire [15:0] awgn_out;

integer n;
integer i;

integer f;

reg [15:0] samples [0:10000000];

// Instantiate the Unit Under Test (UUT)
awgn uut (
	.clk(clk), 
	.rst(rst), 
	.urng_seed1(urng_seed1), 
	.urng_seed2(urng_seed2), 
	.urng_seed3(urng_seed3), 
	.urng_seed4(urng_seed4), 
	.urng_seed5(urng_seed5), 
	.urng_seed6(urng_seed6), 
	.awgn_out(awgn_out)
);

initial begin
	// Initialize Inputs
	clk = 0;
	rst = 1;
	urng_seed1 = 32'h8000_0000;
	urng_seed2 = 32'h8000_0000;
	urng_seed3 = 32'h8000_0000;
	urng_seed4 = 32'h8000_0000;
	urng_seed5 = 32'h8000_0000;
	urng_seed6 = 32'h8000_0000;

	f = $fopen("sample_out.txt","w");

	// Wait 100 ns for global reset to finish
	#100;
	rst = 0; 
	// Add stimulus here

end

always #10 clk = ~clk;

always @(posedge clk or posedge rst)begin
	if (rst) n <= 0;
	else n <= n+1;
end

always @(negedge clk) samples[n] <= awgn_out;

always @(n) begin
	if (n==10000000) begin
		for (i=0;i<n;i=i+1) begin
			$fwrite(f,"%d\n",samples[i]);
		end
		$fclose(f);
		$stop;
	end
end

endmodule

