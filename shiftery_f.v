//Shifter for y_f
module shiftery_f(
	input [19:0] y_f,
	input [4:0] exp_ff,
	output reg [22:0] ff 
);

always @(exp_ff or y_f) begin
case(exp_ff)
	5'b00011: ff <= y_f << 3;
	5'b00010: ff <= y_f << 2;
	5'b00001: ff <= y_f << 1;
	5'b00000: ff <= y_f;
	5'b11111: ff <= y_f >> 1;
	5'b11110: ff <= y_f >> 2;
	5'b11101: ff <= y_f >> 3;
	5'b11100: ff <= y_f >> 4;
	5'b11011: ff <= y_f >> 5;
	5'b11010: ff <= y_f >> 6;
	5'b11001: ff <= y_f >> 7;
	5'b11000: ff <= y_f >> 8;
	5'b10111: ff <= y_f >> 9;
	5'b10110: ff <= y_f >> 10;
	5'b10101: ff <= y_f >> 11;
	5'b10100: ff <= y_f >> 12;
	default: ff <= y_f;
endcase
end

endmodule
