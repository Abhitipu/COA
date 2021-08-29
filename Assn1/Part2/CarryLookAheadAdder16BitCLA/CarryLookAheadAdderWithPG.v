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
`ifndef _CLABlock_v_
`define _CLABlock_v_

`include "SumEvaluator.v"
`include "PGGenerator.v"
`include "CarryForwardGeneratorBlock.v"

module CLA4Block(A, B, C0, Cout, S, Pb, Gb);
        input[3:0] A, B;
        input C0;
		output Cout;
        output[3:0] S;
        output Pb, Gb;

        wire [3:0] Carry, P, G, Cin;

		PG_Generator pggen(A, B, P, G);
		assign Cout = Carry[3];
		Carry_Forward_Generator16Block cgen(P, G, C0, Carry);	
		assign Cin = {Carry[2:0], C0};
        SE getsum(P, Cin, S);
		
        // P=P3P2P1P0
        // G=G3 +P3G2 +P3P2G1 +P3P2P1G0
        assign Pb = P[0]&P[1]&P[2]&P[3];
        assign Gb = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0];
endmodule

`endif
