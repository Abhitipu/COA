`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:19:46 11/08/2021
// Design Name:   InstructionMemory
// Module Name:   C:/Users/Student/Desktop/19CS30007_COA_LAB/Assn7/mybrom/IntructionMemory_tb.v
// Project Name:  mybrom
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstructionMemory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module IntructionMemory_tb;

	// Inputs
	reg clka;
	reg ena;
	reg [31:0] addra;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	InstructionMemory uut (
		.clka(clka), 
		.ena(ena), 
		.addra(addra), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		clka = 0;
		ena = 0;
		addra = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		ena = 1;
		addra = 0;
		#20;
		
		addra = 4;
		#20;
		
		addra = 8;
		#20;
		
		$finish;
	end
    always #10 clka = ~clka;  
endmodule

