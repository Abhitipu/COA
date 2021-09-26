/*
Assignment 5
Problem no: 2
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns
`include "Unsigned_cmp.v"

module UnsignedCmp_tb;
    reg reset;
    wire res;

    initial clk = 1;
    initial reset = 1;
    always #5 clk = ~clk;

    UnsignedCmp unsigned_cmp();

    initial begin
        $dumpfile("UnsignedCmp_tb.vcd");
        $dumpvars(0, unsigned_cmp);


        $display("end of test.");
        $finish;
    end
endmodule
