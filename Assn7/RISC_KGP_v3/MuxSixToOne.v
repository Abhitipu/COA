/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _MUX6TO1_
`define _MUX6TO1_
// make a 6 : 1 mux
module Mux6To1 (
        input i_a,
        input i_b,
        input i_c,
        input i_d,
        input i_e,
        input i_f,
        input[4:0] i_sel,
        output reg o
    );

    // Mux6To1 mux_6to1(.i_a(~carry), .i_b(carry), .i_c(sign), .i_d(1'b1), .i_e(zero), .i_f(~zero), .i_sel(fcode), .o(w4));
    // 
    always @(*) begin
        case (i_sel)
            1: o = i_b; // carry
            2: o = i_a; // ncy
            3: o = i_e; //  zero
            4: o = i_c; // less than zero
            5: o = i_f; // not zero
            default: o = i_d;   // anything else
        endcase
    end
endmodule 
`endif // _MUX6TO1_