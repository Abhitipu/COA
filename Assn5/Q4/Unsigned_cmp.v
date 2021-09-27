/*
Assignment 5
Problem no: 4
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns

`ifndef _UnsignedCmp_v_
`define _UnsignedCmp_v_
`include "Dff.v"
`include "ShiftRegister.v"

module UnsignedCmp(
        input reset,
        input[31:0] A,
        input[31:0] B,
        input op,
        input clk,
        output reg L,
        output reg E,
        output reg G
    );

    wire[1:0] ps, ns;
    wire[31:0] curA, curB;
    // does sel take in op ? check this logic?
    // sel = 1 A will load, Sel = 0; 
    ShiftLoadReg32_struct slr1(A, 1'b0, op, reset, clk, curA);
    ShiftLoadReg32_struct slr2(B, 1'b0, op, reset, clk, curB); 

    // module dff_struct(D, Clk, Reset, CurInput, Set, Q);
    dff_struct dff[1:0] (ns, clk, reset, 1'b0, 1'b0, ps);  // should we use the modified dff?

    assign ns[1] = ps[1] | (~ps[0]) & (~op) & (curA[31] ^ curB[31]);
    assign ns[0] = ps[0] | (curA[31] & (~curB[31]) & (~op));
    
    always @(*) L = ps[1];
    always @(*) G = (~ps[1]) & (ps[0]);
    always @(*) E = (~ps[1]) & (~ps[0]);

endmodule
// state  encoding description
//        Ps1 PS0
// SE        00           Answer Till Now Equal
// SG        01           Answer Till Now Greater
// SL        1x           Answer Till Now Less
// NS0 Logic
// Ns-0 = PS0 +  AB'op'

// NS1 logic
// Ns1 = PS1 + PS0' A'Bop' + PS0' AB'op' = PS1 + PS0'op'(AxorB)

// L = PS1, G = PS1'PS0,  E = PS1' PS0'

`endif 
