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

// module UnsignedCmp(
//         input reset,
//         input[31:0] A,
//         input[31:0] B,
//         input op,
//         input clk,
//         output reg L,
//         output reg E,
//         output reg G
//     );

module UnsignedCmp_tb;
    reg reset, op, clk, sel;
    reg[31:0] A, B;
    wire L, E, G;

    initial clk = 1'b1;
    initial reset = 1'b1;
    initial A = 0;
    initial B = 0;
    initial op = 1'b0;
    initial sel = 0;
    always #5 clk = ~clk;

    UnsignedCmp unsigned_cmp(reset, A, B, op, sel, clk, L, E, G);

    initial begin
        $dumpfile("UnsignedCmp_tb.vcd");
        $dumpvars(0, unsigned_cmp);

        #10;
        
        reset = 0; #10;
        op = 1'b0;sel=1; A = 76521123; B = 128777; #10;sel=0;
        op = 1'b0; #320;
        op=1'b1; #30;

        reset = 1; #10;
        reset = 0; #10;
        op = 1'b1;sel=1; A = 187264; B = 34132312; #10;sel=0;
        op = 1'b0; #320;
        op=1'b1; #30;

        reset = 1; #10;
        reset = 0; #10;
        op = 1'b1;sel=1; A = 3323445; B = 3323445; #10;sel=0;
        op = 1'b0; #320;
        op=1'b1; #30;

        reset = 1; #10;
        reset = 0; #10;
        op = 1'b1;sel=1; A = 1; B = 0; #10;sel=0;
        op = 1'b0; #320;
        op=1'b1; #30;
        $display("end of test.");
        $finish;
    end
endmodule
