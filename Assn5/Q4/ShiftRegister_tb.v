/*
Assignment 5
Problem no: 4
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns / 1ps

module ShiftRegister_tb;

	// Inputs
	reg [31:0] load;
	reg shiftin;
	reg sel;
	reg reset;
	reg clk;

	// Outputs
	wire [31:0] state;

	// Instantiate the Unit Under Test (UUT)
	ShiftLoadReg32_struct uut (
		.load(load), 
		.shiftin(shiftin), 
		.sel(sel), 
		.reset(reset), 
		.clk(clk), 
		.state(state)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		load = 0;
		shiftin = 0;
		sel = 0;
		reset = 0;
		clk = 0;

		#10;
		
		reset = 1; load=1; shiftin=1'b0; #18;
		reset=0; #1;
		sel = 1; #20;
		load = 2; #20;
		sel = 0; #640;     
		
		$finish;

	end
      
endmodule

