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

module ALU_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [3:0] Sel;
	reg clk;

	// Outputs
	wire [31:0] result;
	wire sign;
	wire carry;
	wire zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.A(A), 
		.B(B), 
		.Sel(Sel), 
		.clk(clk), 
		.result(result), 
		.sign(sign), 
		.carry(carry), 
		.zero(zero)
	);
	
	always #1 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		Sel = 0;
		clk = 0;

		// Wait 10 ns for global reset to finish
		#10;
        
		// Add stimulus here
		A = -1e9 + 2734;
		B = 1e9 + 2333;
		Sel = 0;
		#5;
		Sel = 1;
		#5;
		Sel = 2;
		#5;
		Sel = 3;
		#5;
		Sel = 4;
		#5;
		Sel = 5;
		#5;
		Sel = 6;
		#5;
		
		A = 1e6 + 23;
		B = 12;
		Sel = 0;
		#5;
		Sel = 1;
		#5;
		Sel = 2;
		#5;
		Sel = 3;
		#5;
		Sel = 4;
		#5;
		Sel = 5;
		#5;
		Sel = 6;
		#5;
		
		A = 2.3e9 + 121312;
		B = 2.3e9 + 121312;
		Sel = 0;
		#5;
		Sel = 1;
		#5;
		Sel = 2;
		#5;
		Sel = 3;
		#5;
		Sel = 4;
		#5;
		Sel = 5;
		#5;
		Sel = 6;
		#5;
		
		A = 0;
		B = 2e6;
		Sel = 0;
		#5;
		Sel = 1;
		#5;
		Sel = 2;
		#5;
		Sel = 3;
		#5;
		Sel = 4;
		#5;
		Sel = 5;
		#5;
		Sel = 6;
		#5;

		$finish;
		
	end
      
endmodule

