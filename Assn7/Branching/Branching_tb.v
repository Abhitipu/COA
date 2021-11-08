`timescale 1ns / 1ps
`include "Branching.v"

module Branching_tb;

	// Inputs
	reg [31:0] pc;
	reg [31:0] read_data1;
	reg [31:0] label;
	reg [4:0] fcode;
	reg branch;
	reg branchSrc;
	reg sign;
	reg zero;
	reg carry;

	// Outputs
	wire [31:0] next_pc;
	wire [31:0] writeRegData;

	// Instantiate the Unit Under Test (UUT)
	branching uut (
		.pc(pc), 
		.read_data1(read_data1), 
		.label(label), 
		.fcode(fcode), 
		.branch(branch), 
		.branchSrc(branchSrc), 
		.sign(sign), 
		.zero(zero), 
		.carry(carry), 
		.next_pc(next_pc), 
		.writeRegData(writeRegData)
	);

	initial begin
        $dumpfile("Branching_tb.vcd");
        $dumpvars(0,Branching_tb);
		// Initialize Inputs
		pc = 0;			// 32
		read_data1 = 0;	// 32
		label = 0;		// 32
		fcode = 0;		// {0..6}
		branch = 0;		// 1
		branchSrc = 0;	// 0 1
		sign = 0;
		zero = 0;
		carry = 0;

		// Wait 10 ns for global reset to finish
		#10;
      
		pc = 100;
		read_data1 = 200;
		label = 1e4;
		
		branch = 1;
		branchSrc = 1;
		sign = 1;
		zero = 0;
		carry = 1;
		fcode = 0;
		
		#10;
		fcode = 1; // for bcy
		
		#10;
		fcode = 2; // bncy
		
		#10
		fcode = 3;	// bz
		
		#10
		fcode = 4; // bltz
		
		#10
		fcode = 5; // bnz
		
		#10
		fcode = 0;
		
		sign = 0;
		zero = 1;
		carry = 0;
		branchSrc = 0;
		
		#10;
		fcode = 1; // for bcy
		
		#10;
		fcode = 2; // bncy
		
		#10
		fcode = 3;	// bz
		
		#10
		fcode = 4; // bltz
		
		#10
		fcode = 5; // bnz
		
		#10
		fcode = 6;
		
		#10;
		branch = 0;		// turning this off and checking
		branchSrc = 1;
		
		#10;
		fcode = 1; // for bcy
		
		#10;
		fcode = 2; // bncy
		
		#10
		fcode = 3;	// bz
		
		#10
		fcode = 4; // bltz
		
		#10
		fcode = 5; // bnz
		
		#10
		fcode = 6;

		$finish;
	end
      
endmodule

