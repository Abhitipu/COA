`timescale 1ns/1ns
`include "FullAdder.v"

module rca4(A, B, cin1, S, cout1);
 input[3:0] A, B;
 input cin1;
 output[3:0] S;
 output cout1;

 wire c1, c2, c3;
 // 4 instantiated 1-bit full adders
 FA_Struct fa0 (A[0], B[0], cin1, c1, S[0]);
 FA_Struct fa1 (A[1], B[1], c1, c2, S[1]);
 FA_Struct fa2 (A[2], B[2], c2, c3, S[2]);
 FA_Struct fa3 (A[3], B[3], c3, cout1, S[3]);
endmodule