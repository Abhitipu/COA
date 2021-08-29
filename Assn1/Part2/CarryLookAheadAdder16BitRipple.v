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
`ifndef _CLA16R_v_
`define _CLA16R_v_

`include "CarryLookAheadAdder.v"

module CLA16Ripple(A, B, C0, S, Cout);
    input[15:0] A, B;
    input C0;
    output[15:0] S;
    output Cout;
    wire[15:0] Carry;

    CLA4 cla1(A[3:0], B[3:0], C0, Carry[3], S[3:0]);
    CLA4 cla2(A[7:4], B[7:4], Carry[3], Carry[7], S[7:4]);
    CLA4 cla3(A[11:8], B[11:8], Carry[7], Carry[11], S[11:8]);
    CLA4 cla4(A[15:12], B[15:12], Carry[11], Carry[15], S[15:12]);

    assign Cout = Carry[15];
endmodule
`endif // _CLA16R_v_