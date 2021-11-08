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

module datamemory_tb;

	// Inputs
	reg clka;
	reg ena;
	reg [3:0] wea;
	reg [31:0] addra;
	reg [31:0] dina;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	datamemory uut (
		.clka(clka), 
		.ena(ena), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		clka = 0;
		ena = 1'b1;
		wea = 4'b0000;
		addra = 32'b00000000000000000000000000000000;
		dina = 0;
		#29
		wea = 4'b1111;
		addra = 32'b00000000000000000000000000000000;
		dina = 32'd54;
		#20
		wea = 4'b0000;
		#20
		addra = 32'b00000000000000000000000000000100;
		#40;
		$finish;
	end
	always #10 clka = ~clka;
      
endmodule

