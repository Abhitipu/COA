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
module BarrelShifter(
		input [7:0] in,
		input [2:0] shamt,
		input dir, // shift <- dir == 1 ? left : right
		output [7:0] out
	 );
	 
	 /*
	 module Multiplexer(
		input x,
		input u,
		input v,
		output z
	 );
		// z = xu + x'v
	 
	 */
	 wire[7:0] in1_u, in1_v, in2_u, in2_v, in3_u, in3_v;
	 wire[7:0] out1, out2, out3;
	 wire[7:0] temp1, temp2;
	 
	 
	 // 4 bit shift
	 assign in1_u = {in[3:0], 4'b0000};	// for left shift 4 bits: 
	 assign in1_v = {4'b0000, in[7:4]};
	 
	 Multiplexer mux_choose1[7:0](dir, in1_u, in1_v, out1);	// choose between addition and subtraction
	 Multiplexer mux_shift1[7:0](shamt[2], out1, in, temp1);	// choose whether to shift or not
	 
	 // 2 bit shift
	 assign in2_u = {temp1[5:0], 2'b00};	// for left shift 2 bits: 
	 assign in2_v = {2'b00, temp1[7:2]};
	 
	 Multiplexer mux_choose2[7:0](dir, in2_u, in2_v, out2);	
	 Multiplexer mux_shift2[7:0](shamt[1], out2, temp1, temp2);	
	 
	 // 1 bit shift
	 assign in3_u = {temp2[6:0], 1'b0};	// for left shift 1 bit: 
	 assign in3_v = {1'b0, temp2[7:1]};
	 
	 Multiplexer mux_choose3[7:0](dir, in3_u, in3_v, out3);	
	 Multiplexer mux_shift3[7:0](shamt[0], out3, temp2, out);

endmodule
