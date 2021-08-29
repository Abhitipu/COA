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
`include "SumEvaluator.v"

module SumEvaluator_tb;
    reg[3:0] p,cin;
    wire[3:0] sum;
    SE getsum(p,cin,sum);

    initial begin
        $dumpfile("SumEvaluator_tb.vcd");
        $dumpvars(0,SumEvaluator_tb);

        p=4'b0100;cin=4'b1100;#10;
        p=4'b0010;cin=4'b1011;#10;
        p=4'b1111;cin=4'b0000;#10;
        p=4'b1100;cin=4'b1101;#10;
        
        $display("Sum evaluator testing done.");
    end

endmodule
