`timescale 1ns/1ns
`include "FullAdder.v"
`include "Multiplexer.v"

`ifndef _RCA_v_
`define _RCA_v_

module rca8(A, B, cin1, S, cout1);
    input[7:0] A, B;
    input cin1;
    output[7:0] S;
    output cout1;

    wire c1, c2, c3, c4, c5, c6, c7;
    // 4 instantiated 1-bit full adders
    FA_Struct fa0 (A[0], B[0], cin1, c1, S[0]);
    FA_Struct fa1 (A[1], B[1], c1, c2, S[1]);
    FA_Struct fa2 (A[2], B[2], c2, c3, S[2]);
    FA_Struct fa3 (A[3], B[3], c3, c4, S[3]);
    FA_Struct fa4 (A[4], B[4], c4, c5, S[4]);
    FA_Struct fa5 (A[5], B[5], c5, c6, S[5]);
    FA_Struct fa6 (A[6], B[6], c6, c7, S[6]);
    FA_Struct fa7 (A[7], B[7], c7, cout1,S[7]);
endmodule

module rca16 (A, B, cin1, S, cout1);
    input [15:0] A, B;
    input cin1;
    output [15:0] S;
    output cout1;

    wire c1;
    rca8 R1(A[7:0], B[7:0], cin1, S[7:0], c1);
    rca8 R2(A[15:8], B[15:8], c1, S[15:8], cout1);

endmodule

module rca32 (A, B, cin1, S, cout1);
    input [31:0] A, B;
    input cin1;
    output [31:0] S;
    output cout1;

    wire c1;
    rca16 R1(A[15:0], B[15:0], cin1, S[15:0], c1);
    rca16 R2(A[31:16], B[31:16], c1, S[31:16], cout1);

endmodule

module rca64 (A, B, cin1, S, cout1);
    input [63:0] A, B;
    input cin1;
    output [63:0] S;
    output cout1;

    wire c1;
    rca32 R1(A[31:0], B[31:0], cin1, S[31:0], c1);
    rca32 R2(A[63:32], B[63:32], c1, S[63:32], cout1);

endmodule


// ripple carry adder and subtractor, mode 1 for A-B, 0 for A+B
// We convert B to its 2's complement using negation and adding 1 through carry in
// ignore the cout pin
module rcas8 (A, B, mode, S, cout1);
    input [7:0] A, B;
    input mode;
    output [7:0] S;
    output cout1;

    wire[7:0] BMUX;
    multiplexer_struct m0(mode, ~B[0], B[0], BMUX[0]);
    multiplexer_struct m1(mode, ~B[1], B[1], BMUX[1]);
    multiplexer_struct m2(mode, ~B[2], B[2], BMUX[2]);
    multiplexer_struct m3(mode, ~B[3], B[3], BMUX[3]);
    multiplexer_struct m4(mode, ~B[4], B[4], BMUX[4]);
    multiplexer_struct m5(mode, ~B[5], B[5], BMUX[5]);
    multiplexer_struct m6(mode, ~B[6], B[6], BMUX[6]);
    multiplexer_struct m7(mode, ~B[7], B[7], BMUX[7]);
    rca8 R1(A, BMUX, mode, S, cout1);

endmodule
`endif // _RCA_v_