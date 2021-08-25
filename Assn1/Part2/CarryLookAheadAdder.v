`timescale 1ns/1ns
`ifndef _CLA_v_
`define _CLA_v_
`include "FullAdder.v"
`include "CarryGenerator.v"

module CLA(A, B, cin1, S, cout1);
        input[3:0] A, B;
        input cin1;
        output[3:0] S;
        output cout1;

        wire[3:0] C;

	Carry_Generator cgen(A, B, cin1, C);	
        // 4 instantiated 1-bit full adders
	// Doubt: Are these carried out concurrently?
	
        FA_Struct fa0 (A[0], B[0], cin1, C[0], S[0]);
        FA_Struct fa1 (A[1], B[1], C[0], C[1], S[1]);
        FA_Struct fa2 (A[2], B[2], C[1], C[2], S[2]);
        FA_Struct fa3 (A[3], B[3], C[2], C[3], S[3]);

endmodule

`endif
