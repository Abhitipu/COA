/*
Assignment 5
Problem no: 2
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ps

module TwosComp_tb;
    reg bit, reset, clk;
    wire res;

    initial clk = 1;
    initial bit = 0;
    initial reset = 1;
    always #5 clk = ~clk;

    TwosComp twoscomp(reset, bit, clk, res);

    initial begin

        reset = 1; bit = 0;#10; // reset for starting 10ns
        reset = 0; bit = 0; #10;// remove reset and wait 10ns
        bit = 0; #10;           // start feeding input 
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
		  
        reset = 1; bit = 0;#10; // test 2
        reset = 0; bit = 0; #10;
        bit = 0; #10;           // test 2 - starts input bit
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

        reset = 1; bit = 0;#10;
        reset = 0; bit = 0; #10;
        bit = 1; #10;           // test 3 - starts input bit
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

        $finish;
    end
endmodule