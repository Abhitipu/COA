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

module SignExtend17to32(input [17:0] in, output [31:0] out);
    assign out <= {{15{in[16]}}, in};
endmodule