/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _MUX3TO1_32_
`define _MUX3TO1_32_
// make a 3 : 1 mux
module Mux3To1_32 (
        input[31:0] i_a,
        input[31:0] i_b,
        input[31:0] i_c,
        input[1:0] i_sel,
        output reg[31:0] o
    );

    
    always @(*) begin
        case (i_sel)
            0: o = i_a; 
            1: o = i_b; 
            2: o = i_c; 
            default: o = i_a;   // anything else
        endcase
    end
endmodule 
`endif // _MUX3TO1_32_