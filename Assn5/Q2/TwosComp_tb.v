/*
Assignment 5
Problem no: 2
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns / 1ps

module TwosComp_tb;

	// Inputs
	reg reset;
	reg bit;
	reg clk;

	// Outputs
	wire res;

	// Instantiate the Unit Under Test (UUT)
	TwosComp uut (
		.reset(reset), 
		.bit(bit), 
		.clk(clk), 
		.res(res)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		reset = 0;
		bit = 0;
		clk = 0;
		
		#10;
		
		reset = 1; bit = 0;#10;
		reset = 0; bit = 0; #10;
		bit = 0; #10;
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
        
		$finish;
	end
      
endmodule

