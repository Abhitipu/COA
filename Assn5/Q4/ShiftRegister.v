/*
Assignment 5
Problem no: 4
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ps // <time unit> / <time precision>

module ShiftLoadReg32_struct(
        input[31:0] load,
        input shiftin,
        input sel, 
        input reset, 
        input clk,
        output[31:0] state
    );
	
    wire[0:32] w;
    wire [0:31] wint;
	// sel = 1 => set load
    multiplexer_struct mux[31:0] (sel, load, w[1:32], wint);
    dff_struct dff[31:0] (wint, clk, reset, load, sel, w[0:31]);

    assign state[31:0] = {w[0:31]};

    assign w[32] = shiftin;

endmodule