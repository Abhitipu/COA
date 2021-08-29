/*
Assignment 1
Problem no: 2b
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`timescale 1ns/1ns
`include "CarryGenerator.v"

module CarryGenerator_tb;
    
    reg [3:0] A, B;
    reg  C;
    wire[3:0] Cout, P;

    Carry_Forward_Generator cg(A, B, C, Cout, P);

    initial begin
        $dumpfile("CarryGenerator_tb.vcd");
        $dumpvars(0,CarryGenerator_tb);

        A <= 4'b1110; B <= 4'b0111; C <= 0; #10;
        A <= 4'b1001; B <= 4'b1101; C <= 0; #10;
        A <= 4'b0110; B <= 4'b1100; C <= 1; #10;
        A <= 4'b0111; B <= 4'b1110; C <= 1; #10;

        $display("Carry Generator testing done.");
    end

endmodule