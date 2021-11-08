`timescale 1ns / 1ps

`include "AND.v"
module AND_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] And_out;

	// Instantiate the Unit Under Test (UUT)
	AND uut (
		.A(A), 
		.B(B), 
		.And_out(And_out)
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

