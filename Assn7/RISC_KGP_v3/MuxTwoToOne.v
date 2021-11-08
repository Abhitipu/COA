/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _MUX2TO1_
`define _MUX2TO1_
// make a 2 : 1 mux
module Mux2To1 (
        input[31:0] i_a,
        input[31:0] i_b,
        input i_sel,
        output [31:0] o
    ); 
    
    assign o = (i_sel)? i_a : i_b;

endmodule 
`endif // _MUX2TO1_