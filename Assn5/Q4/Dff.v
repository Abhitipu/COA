/*
Assignment 5
Problem no: 4
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ps // <time unit> / <time precision>

module dff_struct(D, Clk, Reset, CurInput, Set, Q);
	input D, Clk, CurInput, Set, Reset;
	output reg Q;
	
    always @(posedge Clk or posedge Reset or posedge Set)
        begin
            if(Reset)
                Q <= 1'b0;
            else if (Set)
                Q <= CurInput;
            else
                Q <= D;
        end
endmodule