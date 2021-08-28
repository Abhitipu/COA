`timescale 1ns/1ns

`ifndef _PGGenerator_v_
`define _PGGenerator_v_

module PG_Generator(A, B, P, G);
	output[3:0] P, G;
	input[3:0] A, B;
	
	assign P = A^B;
	assign G = A&B;

endmodule // PG_Generator

`endif // _PGGenerator_v_
