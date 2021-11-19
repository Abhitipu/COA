`timescale 1ns / 1ps
/*
Assignment 6
Problem no: 1
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`include "BarrelShifter.v"
module BarrelShifter_tb;

	// Inputs
	reg [7:0] in;
	reg [2:0] shamt;
	reg dir;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	BarrelShifter uut (
		.in(in), 
		.shamt(shamt), 
		.dir(dir), 
		.out(out)
	);

	initial begin
		$dumpfile("BarrelShifter_tb.vcd");
        $dumpvars(0,BarrelShifter_tb);
		// Initialize Inputs
		in = 8'b00000000;		// the 8 bit input
		shamt = {3'b000};
		dir = 1'b0;		// shift <- dir == 1 ? left : right
		
		#20;
		
		in = 8'b01100110;
		shamt = 3'b000;
		dir = 1'b1;
		
		#20;

		shamt = 1;
		#20;

		shamt = 2;
		#20;

		shamt = 3;
		#20;

		shamt = 4;
		#20;

		shamt = 5;
		#20;

		shamt = 6;
		#20;

		shamt = 7;
		#20;

		in = 255;
		dir = 1'b0;
		shamt = 0;
		#20;

		shamt = 1;
		#20;

		shamt = 2;
		#20;

		shamt = 3;
		#20;

		shamt = 4;
		#20;

		shamt = 5;
		#20;

		shamt = 6;
		#20;

		shamt = 7;
		#20;
		$display("End of Test!");
	end
      
endmodule

