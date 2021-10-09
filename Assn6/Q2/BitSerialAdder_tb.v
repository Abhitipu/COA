/*
Assignment 6
Problem no: 2
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns
`include "BitSerialAdder.v"

module BitSerialAdder_tb;
    // inputs
    reg[7:0] a,b;
    reg mode;
    reg reset;
    reg clk;
    // outputs
    wire cout;
    wire [7:0] sum;

    BitSerialAdder uut(
        .A(a),
        .B(b),
        .clk(clk),
        .mode(mode),
        .reset(reset),
        .Sum(sum),
        .Cout(cout)
    );
    
    always #5 clk = ~clk;

    initial begin
        $dumpfile("BitSerialAdder_tb.vcd");
        $dumpvars(0,BitSerialAdder_tb);

        clk = 0;
        mode = 0;
        a = 35;
        b = 26;
        reset = 1;
        #15;

        reset = 0;
        mode = 1;
        #10;

        mode = 0;
        #90;



        a = 4;
        b = 1;
        reset = 1;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #90;

        a = 9;
        b = 21;
        reset = 1;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #90;

        a = 55;
        b = 67;
        reset = 1;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #90;

        a = 205;
        b = 67;
        reset = 1;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #90;

        a = 205;
        b = 159;
        reset = 1;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #90;

        a = -69;
        b = -125;
        reset = 1;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #90;

        a = -15;
        b = -30;
        reset = 1;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #90;

        a = 50;
        b = -100;
        reset = 1;
        #15;
        reset = 0;
        mode = 1;
        #10;
        mode = 0;
        #90;

        $display("end of test.");
        $finish;
    end

endmodule
