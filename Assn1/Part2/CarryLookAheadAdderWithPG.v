`timescale 1ns/1ns
`ifndef _CLABlock_v_
`define _CLABlock_v_

`include "FullAdderWithoutCarry.v"
`include "PGGenerator.v"

module Carry_Forward_Generator16Block(P, G, C0, Cout);
	input[3:0] P, G;
	input C0;

	output[3:0] Cout;
	
	// C1 = G0 + P0C0
	assign Cout[0] = G[0] | P[0]&C0;
	// C2 = G1 + P1G0 + P1P0C0
	assign Cout[1] = G[1] | P[1]&G[0] | P[1]&P[0]&C0;		
	// C3 = G2 + P2G1 + P2P1G0 + P2P1P0C0
	assign Cout[2] = G[2] | P[2]&G[1] | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&C0;	
	// C4 = G3 + P3G2 + P3P2G1 + P3P2P1G0 + P3P2P1P0G0
	assign Cout[3] = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&C0;
endmodule // Carry_Forward_GeneratorBLock

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
        FA_Struct fa0 (P, Cin, S);
		
        // P=P3P2P1P0
        // G=G3 +P3G2 +P3P2G1 +P3P2P1G0
        assign Pb = P[0]&P[1]&P[2]&P[3];
        assign Gb = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0];
endmodule

`endif
