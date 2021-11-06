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

module RightShiftArithmetic_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] RightShiftedArithmetic_A;

	// Instantiate the Unit Under Test (UUT)
	RightShiftArithmetic uut (
		.A(A), 
		.B(B), 
		.RightShiftedArithmetic_A(RightShiftedArithmetic_A)
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
		
		A = -1e9 + 7;
		B = 32;
		#50;
		
		A = 1e6 + 245;
		B = 13;
		#50;
		
		A = -1e6 + 245;
		B = 7;
		#50;

	end
      
endmodule

