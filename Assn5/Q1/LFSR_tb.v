
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
`include "LFSR.v"
// lfsr_struct(
//         input[3:0] seed,
//         input sel, 
//         input reset, 
//         input clk,
//         output[3:0] state
//     );

module LFSR_tb;
    reg[3:0] seed;
    reg sel, reset, clk;
    wire[3:0] state;
    initial clk = 0;
    always #5 clk = ~clk;

    lfsr_struct lfsr(seed, sel, reset, clk, state);

    initial begin
        $dumpfile("LFSR_tb.vcd");
        $dumpvars(0, lfsr);

        reset = 1; #10;
        sel = 1; seed=4'b1111; reset=0; #10;
        sel = 0; #160;

        sel = 1; seed=4'b1010; reset=0; #10;
        sel = 0; #160;

        sel = 1; seed=4'b1001; reset=0; #10;
        sel = 0; #160;

        $display("end of test.");
        $finish;
    end
endmodule
