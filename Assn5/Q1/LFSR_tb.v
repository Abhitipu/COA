/*
Assignment 5
Problem no: 1
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns / 1ps

module LFSR_tb;

	// Inputs
	reg [3:0] seed;
	reg sel;
	reg reset;
	reg clk;

	// Outputs
	wire [3:0] state;

	// Instantiate the Unit Under Test (UUT)
	lfsr_struct uut (
		.seed(seed), 
		.sel(sel), 
		.reset(reset), 
		.clk(clk), 
		.state(state)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		seed = 0;
		sel = 0;
		reset = 0;
		clk = 0;
		
		#10
        
		reset = 1; #10;
		sel = 1; seed=4'b1111; reset=0; #10;
		sel = 0; #160;

		sel = 1; seed=4'b1010; reset=0; #10;
		sel = 0; #160;

		sel = 1; seed=4'b1001; reset=0; #10;
		sel = 0; #160;
	end
      
endmodule

