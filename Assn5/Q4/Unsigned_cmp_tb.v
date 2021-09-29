`timescale 1ns / 1ps
/*
Assignment 5
Problem no: 4
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

module UnsignedCmp_tb;

	// Inputs
	reg reset;
	reg [31:0] A;
	reg [31:0] B;
	reg op;
	reg sel;
	reg clk;

	// Outputs
	wire L;
	wire E;
	wire G;

	// Instantiate the Unit Under Test (UUT)
	UnsignedCmp uut (
		.reset(reset), 
		.A(A), 
		.B(B), 
		.op(op), 
		.sel(sel), 
		.clk(clk), 
		.L(L), 
		.E(E), 
		.G(G)
	);
	
	always #2 clk = ~clk;

	initial begin
		// Initialize Inputs
		reset = 1;
		A = 0;
		B = 0;
		op = 0;
		sel = 0;
		clk = 1;

		#4;
        
		reset = 0; op = 1'b0; sel=1; A = 76521123; B = 128777; #4
		// turn off reset
		// set op to 0 -> feed input
		// set sel to 1 -> load mode
		// supply the 32 bit inputs
		
		sel=0; #128;
		// set sel to 0 -> shift mode
		
		op=1'b1; #8;
		// set op to 1 -> for checking result

		reset = 1; #4;
		// reset m/c
		
		// repeat
		reset = 0; op = 1'b0; sel=1; A = 187264; B = 34132312; #4;
		sel=0; #128;
		op=1'b1; #8;

		reset = 1; #4;
		reset = 0; op = 1'b0; sel=1; A = 3323445; B = 3323445; #4;
		sel=0; #128;
		op=1'b1; #8;

		reset = 1; #4;
		reset = 0; op = 1'b0; sel=1; A = 1; B = 0; #4;
		sel=0; #128;
		op=1'b1; #8;
		
		reset = 1; #4;
		$finish;

	end
      
endmodule