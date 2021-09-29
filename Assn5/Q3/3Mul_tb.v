/*
Assignment 5
Problem no: 3
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns
`include "3Mul.v"

module ThreeMul_tb;
    reg bit, reset, clk;
    wire res;

    initial clk = 1;
    initial bit = 0;
    initial reset = 1;
    always #5 clk = ~clk;

    ThreeMul threemul(reset, bit, clk, res);

    initial begin
        $dumpfile("ThreeMul_tb.vcd");
        $dumpvars(0, threemul);

        reset = 1; #10;
        reset = 0; bit = 1; #10;
        bit = 1; #10;
        bit = 0; #10;
        bit = 0; #10;
        bit = 1; #10;
        bit = 1; #10;
        bit = 0; #10;
        bit = 1; #10;
        bit = 1; #10;
        bit = 0; #10;
        bit = 0; #10;
        bit = 1; #10;
        bit = 1; #20;
        bit = 0; #20;

        $display("end of test.");
        $finish;
    end
endmodule
