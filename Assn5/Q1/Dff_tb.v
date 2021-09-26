/*
Assignment 5
Problem no: 1
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns
`include "Dff.v"

module Dff_tb;
    reg clk, D, Reset;
    wire Q;

    initial clk = 0;
    initial D = 0;
    initial Reset = 0;
    always #5 clk = ~clk;

    dff_struct dff(D, clk, Reset, Q);

    initial begin
        $dumpfile("Dff_tb.vcd");
        $dumpvars(0, dff);

        D=0;Reset=1;#4;
        D=1;Reset=0;#3;
        D=1;Reset=0;#20;
        D=0;#20;

        D=1;Reset=1;#17;
        D=0;Reset=0;#11;
        D=1;Reset=0;#23;

        $display("end of test.");
        $finish;
    end
endmodule
