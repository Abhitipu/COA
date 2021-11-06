/*
Assignment 7
Problem no: 5
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _BS_
`define _BS_
`include "Multiplexer.v"
module BarrelShifter(
		input [31:0] in,
		input [4:0] shamt,
		input dir, // shift <- dir == 1 ? left : right
		input feedinbit,
		output [31:0] out
	 );
	 
	 wire[31:0] in1_u, in1_v, in2_u, in2_v, in3_u, in3_v, in4_u, in4_v, in5_u, in5_v;
	 wire[31:0] out1, out2, out3, out4, out5;
	 wire[31:0] temp1, temp2, temp3, temp4;
	 
	 // 16 bit shift
	 assign in1_u = {in[15:0], 16'b0};	// for left shift 16 bits 
	 assign in1_v = {{16{feedinbit}}, in[31:16]}; // for right shift 16 bits
	 
	 Multiplexer mux_choose1[31:0](dir, in1_u, in1_v, out1);	// choose between addition and subtraction
	 Multiplexer mux_shift1[31:0](shamt[4], out1, in, temp1);	// choose whether to shift or not

	 // 8 bit shift
	 assign in2_u = {temp1[23:0], 8'b0};	// for left shift 8 bits: 
	 assign in2_v = {{8{feedinbit}}, temp1[31:8]}; 	// for right shift 8 bits
	 
	 Multiplexer mux_choose2[31:0](dir, in2_u, in2_v, out2);	// choose between addition and subtraction
	 Multiplexer mux_shift2[31:0](shamt[3], out2, temp1, temp2);	// choose whether to shift or not

	 // 4 bit shift
	 assign in3_u = {temp2[27:0], 4'b0};	// for left shift 4 bits: 
	 assign in3_v = {{4{feedinbit}}, temp2[31:4]}; 	// for right shift 4 bits
	 
	 Multiplexer mux_choose3[31:0](dir, in3_u, in3_v, out3);	// choose between addition and subtraction
	 Multiplexer mux_shift3[31:0](shamt[2], out3, temp2, temp3);	// choose whether to shift or not
	 
	 // 2 bit shift
	 assign in4_u = {temp3[29:0], 2'b0};	// for left shift 2 bits: 
	 assign in4_v = {{2{feedinbit}}, temp3[31:2]};	// for right shift 2 bits
	 
	 Multiplexer mux_choose4[31:0](dir, in4_u, in4_v, out4);	
	 Multiplexer mux_shift4[31:0](shamt[1], out4, temp3, temp4);	
	 
	 // 1 bit shift
	 assign in5_u = {temp4[30:0], 1'b0};	// for left shift 1 bit: 
	 assign in5_v = {{feedinbit}, temp4[31:1]}; 	// for right shift 1 bit
	 
	 Multiplexer mux_choose5[31:0](dir, in5_u, in5_v, out5);	
	 Multiplexer mux_shift5[31:0](shamt[0], out5, temp4, out);

endmodule

`endif //_BS_