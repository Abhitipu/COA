/*
Assignment 1
Problem no: 2b
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`timescale 1ns/1ns
`ifndef _CLA_v_
`define _CLA_v_

`include "SumEvaluator.v"
`include "CarryGenerator.v"

module CLA4(A, B, C0, Cout, S);
        input[3:0] A, B;
        input C0;
        output Cout;
        output[3:0] S;

        wire[3:0] Carry, P;

	Carry_Forward_Generator cgen(A, B, C0, Carry, P);	
        // 4 instantiated 1-bit full adders

        wire[3:0] Cin;
        assign Cin = {Carry[2:0], C0};
        SE getsum(P, Cin, S);
        assign Cout = Carry[3];
endmodule

`endif
