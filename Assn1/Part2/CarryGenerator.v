`timescale 1ns/1ns

`ifndef _CF_Gen_v_
`define _CF_Gen_v_

`include "PGGenerator.v"

module Carry_Forward_Generator(A, B, C0, Cout, P);
	input[3:0] A, B;
	input C0;
	output[3:0] Cout, P;
	
	wire[3:0] G;
	
	PG_Generator pggen(A, B, P, G);
	// C1 = G0 + P0C0
	assign Cout[0] = G[0] | P[0]&C0;
	// C2 = G1 + P1G0 + P1P0C0
	assign Cout[1] = G[1] | P[1]&G[0] | P[1]&P[0]&C0;		
	// C3 = G2 + P2G1 + P2P1G0 + P2P1P0C0
	assign Cout[2] = G[2] | P[2]&G[1] | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&C0;	
	// C4 = G3 + P3G2 + P3P2G1 + P3P2P1G0 + P3P2P1P0G0
	assign Cout[3] = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&C0;
endmodule // Carry_Forward_Generator

`endif // _CF_Gen_v_
