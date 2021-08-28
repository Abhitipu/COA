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

        wire[3:0] Carry, P;

	Carry_Forward_Generator cgen(A, B, C0, Carry, P);	
        // 4 instantiated 1-bit full adders

        wire[3:0] Cin;
        assign Cin = {Carry[2:0], C0};
        FA_Struct fa0 (P, Cin, S);
        assign Cout = Carry[3];
endmodule

`endif
