
/*
Assignment 5
Problem no: 4
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns
`include "ShiftRegister.v"

// ShiftLoadReg32_struct(
//         input[31:0] load,
//         input shiftin,
//         input sel, 
//         input reset, 
//         input clk,
//         output[31:0] state
//     );

module ShiftLoadReg_tb;
    reg[31:0] load;
    reg shiftin, sel, reset, clk;
    wire[31:0] state;
    initial clk = 0;
    initial sel = 0;
    always #5 clk = ~clk;

    ShiftLoadReg32_struct sflr(load, shiftin, sel, reset, clk, state);

    initial begin
        $dumpfile("ShiftRegister_tb.vcd");
        $dumpvars(0, sflr);

        reset = 1; load=1; shiftin=1'b0; #18;
        reset=0; #1;
        sel = 1; #20;
        load = 2; #20;
        sel = 0; #640;

        $display("end of test.");
        $finish;
    end
endmodule
