/*
Assignment 6
Problem no: 3
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`timescale 1ns/1ns
`include "BoothMulShiftReg.v"

module BoothMulShiftReg_tb;
    // inputs
    reg [7:0] A, B;
    reg mode;
    reg reset;
    reg clk;

    // Outputs
    wire[15:0] parallelOut;
    bmsr uut(
        .parallelIn(A),
        .Multiplicand(B),
        .mode(mode),
        .reset(reset),
        .clk(clk),
        .parallelOut(parallelOut)
    );
    always #5 clk = ~clk;

    initial begin
        $dumpfile("BoothMulShiftReg_tb.vcd");
        $dumpvars(0,BoothMulShiftReg_tb);
        clk = 0;
        mode = 0;
        reset = 1;
        A = 45;
        B = 36;
        #15;

        reset = 0;
        mode = 1;
        #10;

        mode = 0;
        #80;


        reset = 1;
        A = -87;
        B = 127;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #80;

        reset = 1;
        A = -127;
        B = -127;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #80;
        
        reset = 1;
        A = -125;
        B = 127;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #80;

        reset = 1;
        A = -114;
        B = 0;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #80;
        $display("End of test!");
        $finish;

    end
endmodule