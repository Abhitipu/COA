
/*
Assignment 1
Problem no: 1d
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns // <time unit> / <time precision>

`ifndef _LFSR_V_
`define _LFSR_V_
`include "Dff.v"
`include "Multiplexer.v"

// module dff_struct(D, Clk, Reset, Q);
// module multiplexer_struct(x , u , v , z);
// z = xu + x_bar.v

module lfsr_struct(
        input[3:0] seed,
        input sel, 
        input reset, 
        input clk,
        output[3:0] state
    );
	
    wire[4:0] w;
    wire [3:0] wint;
	// sel = 1 => set seed

    multiplexer_struct mux3(sel, seed[3], w[0], wint[0]);
    dff_struct dff3(wint[0], clk, reset, w[1]);
    assign state[3] = w[1];

    multiplexer_struct mux2(sel, seed[2], w[1], wint[1]);
    dff_struct dff2(wint[1], clk, reset, w[2]);
    assign state[2] = w[2];

    multiplexer_struct mux1(sel, seed[1], w[2], wint[2]);
    dff_struct dff1(wint[2], clk, reset, w[3]);
    assign state[1] = w[3];

    multiplexer_struct mux0(sel, seed[0], w[3], wint[3]);
    dff_struct dff0(wint[3], clk, reset, w[4]);
    assign state[0] = w[4];

    xor x1(w[0], w[4], w[3]);

endmodule

`endif // _MUX_v_