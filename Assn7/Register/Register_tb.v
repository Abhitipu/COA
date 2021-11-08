/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`timescale 1ns / 1ps
`include "Register.v"
module Register_tb;

	// Inputs
	reg [31:0] writeToReg;
	reg enable;
	reg clk;
    reg reset;


	// Outputs
	wire [31:0] data;


	// Instantiate the Unit Under Test (UUT)
	Register uut (
		.writeToReg(writeToReg), 
		.enable(enable), 
		.clk(clk), 
		.reset(reset), 
		.data(data) 
	);
	
	always #5 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		writeToReg = 0;
        enable = 0;
        clk = 0;
        reset = 1;

		// Wait 20 ns for global reset to finish
		#20;
        
        enable = 1;
        reset = 0;
        writeToReg = 5;
        #10;

        
        writeToReg = 15;
        #10;
        
        writeToReg = 25;
        #10;

        enable = 0;
        reset = 0;
        writeToReg = 15;
        #20;

        enable = 1;
        reset = 1;
        writeToReg = 5;
        #10;
        // $finish
	end
      
endmodule

