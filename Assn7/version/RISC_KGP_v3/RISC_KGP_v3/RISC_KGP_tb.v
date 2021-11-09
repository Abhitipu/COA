`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:09:09 11/08/2021
// Design Name:   risc_kgp
// Module Name:   C:/Users/Abhinandan/Desktop/Xilinx_files/RISC_KGP_v3/RISC_KGP_tb.v
// Project Name:  RISC_KGP_v3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: risc_kgp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RISC_KGP_tb;

	// Inputs
	reg clk;
	reg clka;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	risc_kgp uut (
		.clk(clk),
		.clka(clka),
		.reset(reset)
	);
	always begin 
	#9; clk = ~clk;
	#1; clka = ~clka; 
	end
	initial begin
		// Initialize Inputs
		clk = 0;clka = 0;
		
		reset = 1;

		// Wait 10 ns for global reset to finish
		#10;
		reset = 0;
		#200;
		$finish;
	end
      
endmodule

