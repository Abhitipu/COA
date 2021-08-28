`timescale 1ns/1ns
`ifndef _CLA16C_v_
`define _CLA16C_v_

`include "CarryLookAheadAdderWithPG.v"
`include "CarryForwardGeneratorBlock.v"

module CLA16CLA(A, B, C0, Carry, S, P, G);
        input[15:0] A, B;
        input C0;
        output Carry;
        output[15:0] S;
        output [3:0] P, G;

		wire[3:0] cout;

        assign Carry = cout[3];
        // 4 instantiated 1-bit full adders
        // Doubt: Are these carried out concurrently?
        // CLA4Block(A, B, C0, Carry, S, Pb, Gb);
        CLA4Block cla4blk0 (A[3:0], B[3:0], C0, ,S[3:0], P[0], G[0]);
        CLA4Block cla4blk1 (A[7:4], B[7:4], cout[0], ,S[7:4], P[1], G[1]);
        CLA4Block cla4blk2 (A[11:8], B[11:8], cout[1], ,S[11:8], P[2], G[2]);
        CLA4Block cla4blk3 (A[15:12], B[15:12], cout[2], ,S[15:12], P[3], G[3]);
        Carry_Forward_Generator16Block cfg(P, G, C0, cout);

endmodule

`endif // _CLA16C_v_
