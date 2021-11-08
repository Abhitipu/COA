/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`timescale 1ns / 1ps

`include "XOR.v"
module XOR_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] Xor_out;

	// Instantiate the Unit Under Test (UUT)
	XOR uut (
		.A(A), 
		.B(B), 
		.Xor_out(Xor_out)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		A = 1e9 + 7;
		B = 143;
		#50;
		
		A = 1e9 + 7;
		B = 324521;
		#50;
		
		A = 1e6 + 245;
		B = 134422;
		#50;
		
		A = 1e6 + 245;
		B = 145457;
		#50;

		$finish;
	end
      
endmodule

