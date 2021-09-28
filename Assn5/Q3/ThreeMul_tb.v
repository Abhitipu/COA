`timescale 1ns / 1ps
/*
Assignment 5
Problem no: 3
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

module ThreeMul_tb;

	// Inputs
	reg reset;
	reg bit;
	reg clk;

	// Outputs
	wire res;
	
	always #5 clk = ~clk;

	// Instantiate the Unit Under Test (UUT)
	ThreeMul uut (
		.reset(reset), 
		.bit(bit), 
		.clk(clk), 
		.res(res)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		bit = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		reset = 1; #10;
		reset = 0; bit = 1; #10;
		bit = 1; #10;
		bit = 0; #10;
		bit = 0; #10;	
		bit = 1; #10;
		bit = 1; #10;
		bit = 0; #10;
		bit = 1; #10;
		bit = 1; #10;
		bit = 0; #10;
		bit = 0; #10;
		bit = 1; #10;
		bit = 1; #20;
		bit = 0; #20;
		
		$finish;

	end
      
endmodule

