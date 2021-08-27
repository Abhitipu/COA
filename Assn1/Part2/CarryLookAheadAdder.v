`timescale 1ns/1ns
`ifndef _CLA_v_
`define _CLA_v_

`include "FullAdderWithoutCarry.v"
`include "CarryGenerator.v"

module CLA4(A, B, C0, Cout, S);
        input[3:0] A, B;
        input C0;
        output Cout;
        output[3:0] S;

        wire[3:0] Carry;

	Carry_Forward_Generator cgen(A, B, C0, Carry);	
        // 4 instantiated 1-bit full adders
	// Doubt: Are these carried out concurrently?
        FA_Struct fa0 (A[0], B[0], C0, S[0]);
        FA_Struct fa1 (A[1], B[1], Carry[0], S[1]);
        FA_Struct fa2 (A[2], B[2], Carry[1], S[2]);
        FA_Struct fa3 (A[3], B[3], Carry[2], S[3]);

        assign Cout = Carry[3];
endmodule

`endif
