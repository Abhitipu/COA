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
		// Initialize Inputs
		in = 8'b00000000;		// the 8 bit input
		shamt = {3'b000};
		dir = 1'b0;		// shift <- dir == 1 ? left : right
		
		#100;
		
		in = 8'b01100110;
		shamt = 3'b011;
		dir = 1'b1;
		
		#200;
		
		in = 8'b01100110;
		shamt = 3'b011;
		dir = 1'b0;
		
		#200;
		
		in = 8'b01110110;
		shamt = 5;
		dir = 1'b1;
		
		#200;
		
		in = 8'b01110110;
		shamt = 5;
		dir = 1'b0;
		
		#2;
	end
      
endmodule

