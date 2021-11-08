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

module RegisterFile_tb;

	// Inputs
	reg reg_write;
	reg clk;
	reg reset;
	reg [4:0] read_register1;
	reg [4:0] read_register2;
	reg [4:0] write_register;
	reg [31:0] write_data;

	// Outputs
	wire [31:0] read_data1;
	wire [31:0] read_data2;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut (
		.reg_write(reg_write), 
		.clk(clk), 
		.reset(reset), 
		.read_register1(read_register1), 
		.read_register2(read_register2), 
		.write_register(write_register), 
		.write_data(write_data), 
		.read_data1(read_data1), 
		.read_data2(read_data2)
	);

	always #1 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		reg_write = 0;
		clk = 0;
		reset = 1;
		read_register1 = 0;
		read_register2 = 0;
		write_register = 0;
		write_data = 0;

		// Wait 10 ns for global reset to finish
		#10;
        
		// Add stimulus here
		reset = 1'b0;
		read_register1 = 5'b1;
		read_register2 = 5'b10;
		write_data = 123;
		write_register = 5'b11;
		reg_write = 1'b1;
		
		#10;
		
		read_register1 = 5'b11;
		read_register2 = 5'b1111;
		write_data = 144;
		write_register = 5'b1111;
		reg_write = 1'b0;
		
		#10;
		
		read_register1 = 5'b1111;
		read_register2 = 5'b1011;
		write_data = 1000;
		write_register = 5'b11111;
		reg_write = 1'b1;
		
		#10;
		
		read_register1 = 5'b11111;
		read_register2 = 5'b10;
		write_data = 123;
		write_register = 5'b11;
		reg_write = 1'b1;
		reset = 1'b1;
		
		#10;
		
	end
      
endmodule

