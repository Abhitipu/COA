/*
Assignment 6
Problem no: 1
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ps
`include "Multiplexer.v"

module Multiplexer_tb;
    reg x,u,v;
    wire z;

    Multiplexer mux(x,u,v,z);

    initial begin
        $dumpfile("Multiplexer_tb.vcd");
        $dumpvars(0,Multiplexer_tb);

        x=1;u=0;v=0;#20;
        x=1;u=1;v=0;#20;
        x=1;u=0;v=1;#20;
        x=0;#20;
        $display("end of test.");
    end
endmodule
