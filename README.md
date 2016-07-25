# AWGN
The matlab code "awgn.m" is for the whole process. "readsample.m" read the 10million samples from verilog simulation and compare with idea normal distribution. "rom_gen.m" generates the binary coefficents from floating coefficients for hardware.

The testbench "awgntb.v" generates 10million noise samples and prints all of them into the "samples.txt" for analysis. The other testbench "awgntb_err.v generate 100000 samples and compare the bit error with the samples from matlab.
