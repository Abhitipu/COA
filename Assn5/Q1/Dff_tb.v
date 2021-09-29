/*
Assignment 5
Problem no: 1
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ps

module Dff_tb;

	// Inputs
	reg D;
	reg Clk;
	reg Reset;

	// Outputs
	wire Q;

	// Instantiate the Unit Under Test (UUT)
	dff_struct uut (
		.D(D), 
		.Clk(Clk), 
		.Reset(Reset), 
		.Q(Q)
	);
	
	always #5 Clk = ~Clk;

	initial begin
		// Initialize Inputs
		D = 0;
		Clk = 0;
		Reset = 0;

		#10;
        
		// feed in inputs and check if reset works
		D=0;Reset=1;#4;
		D=1;Reset=0;#3;
		D=1;Reset=0;#20;
		D=0;#20;

		D=1;Reset=1;#17;
		D=0;Reset=0;#11;
		D=1;Reset=0;#23;
		$finish;
	end
      
endmodule

