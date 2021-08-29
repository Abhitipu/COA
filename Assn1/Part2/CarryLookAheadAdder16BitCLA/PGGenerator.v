/*
Assignment 1
Problem no: 2c
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`timescale 1ns/1ns

`ifndef _PGGenerator_v_
`define _PGGenerator_v_

module PG_Generator(A, B, P, G);
	output[3:0] P, G;
	input[3:0] A, B;
	
	assign P = A^B;
	assign G = A&B;

endmodule // PG_Generator

`endif // _PGGenerator_v_
