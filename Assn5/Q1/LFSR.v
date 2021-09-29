
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
	
    wire[0:4] w;
    wire [0:3] wint;
	// sel = 1 => set seed
    multiplexer_struct mux[3:0] (sel, seed, w[0:3], wint);
    dff_struct dff[3:0] (wint, clk, reset, w[1:4]);

    assign state[3:0] = {w[1:4]};
    xor x1(w[0], w[4], w[3]);

endmodule

`endif // _MUX_v_