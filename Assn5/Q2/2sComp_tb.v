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
`include "2sComp.v"
// TwosComp(
//         input reset,
//         input bit,
//         input clk,
//         output reg res
//     );

module TwosComp_tb;
    reg bit, reset, clk;
    wire res;

    initial clk = 0;
    initial bit = 0;
    initial reset = 1;
    always #5 clk = ~clk;

    TwosComp twoscomp(reset, bit, clk, res);

    initial begin
        $dumpfile("2sComp_tb.vcd");
        $dumpvars(0, twoscomp);

        reset = 1; bit = 0;#10;
        reset = 0; bit = 0; #10;
        bit = 0; #10;
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

        $display("end of test.");
        $finish;
    end
endmodule
