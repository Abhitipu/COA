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
`include "BarrelShifter.v"

module BarrelShifter_tb;

	// Inputs
	reg [31:0] in;
	reg [4:0] shamt;
	reg dir;
	reg feedinbit;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	BarrelShifter uut (
		.in(in), 
		.shamt(shamt), 
		.dir(dir), 
		.feedinbit(feedinbit), 
		.out(out)
	);

	initial begin
        $dumpfile("BarrelShifter_tb.vcd");
        $dumpvars(0,BarrelShifter_tb);
		// Initialize Inputs
		in = 0;
		shamt = 0;
		dir = 0;
		feedinbit = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		in = 32'b10110110010100100101000100100100;
		shamt = 23;
		dir = 1;
		feedinbit = 0;
		
		#50;
		
		// Add stimulus here
		in = 32'b10010100010101100101100110101111;
		shamt = 12;
		dir = 0;
		feedinbit = 1;
		
		#50;
		
		// Add stimulus here
		in = 32'b00110000010111100101000101000010;
		shamt = 7;
		dir = 0;
		feedinbit = 0;
		
		#50;

		$finish;
	end
      
endmodule

