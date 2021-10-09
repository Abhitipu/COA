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
`include "ShiftRegister.v"
// module shift_register(
//     input[7:0] parallelIn,
//     input serialIn,
//     input mode,
//     input reset,
//     input clk,
//     output reg serialOut,
//     output reg[7:0] state
// );
module ShiftRegister_tb;
    // inputs
    reg [7:0] load;
    reg shiftin;
    reg mode;
    reg reset;
    reg clk;

    // Outputs
    wire serialOut;
    wire[7:0] parallelOut;
    shift_register uut(
        .parallelIn(load),
        .serialIn(shiftin),
        .mode(mode),
        .reset(reset),
        .clk(clk),
        .serialOut(serialOut),
        .state(parallelOut)
    );
    always #5 clk = ~clk;

    initial begin
        $dumpfile("ShiftRegister_tb.vcd");
        $dumpvars(0,ShiftRegister_tb);
        reset = 1;
        load = 0;
        mode = 0;
        shiftin = 0;
        clk = 0;
        #10;

        reset = 0;
        load = 9;
        mode = 1;
        #10;

        mode = 0;
        #90;

        reset = 1;#10;
        reset = 0;
        load = 28;
        mode = 1;
        #10;

        mode = 0;
        #90;

        reset = 1;#10;
        reset = 0;
        load = 28;
        mode = 1;
        #10;

        $display("End of test!");
        $finish;

    end
endmodule