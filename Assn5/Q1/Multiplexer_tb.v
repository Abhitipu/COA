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

module Multiplexer_tb;

	// Inputs
	reg x;
	reg u;
	reg v;

	// Outputs
	wire z;

	// Instantiate the Unit Under Test (UUT)
	multiplexer_struct uut (
		.x(x), 
		.u(u), 
		.v(v), 
		.z(z)
	);

	initial begin
		// Initialize Inputs
		x = 0;
		u = 0;
		v = 0;
		
		#10
		
		x=1;u=0;v=0;#20;
		x=1;u=1;v=0;#20;
		x=1;u=0;v=1;#20;
		x=0;#20;
		
		$finish;

	end
      
endmodule

