/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`include "Adder.v"
`include "MuxSixToOne.v"
`include "MuxTwoToOne.v"

`ifndef _BRANCH_
`define _BRANCH_
module branching(
        input [31:0] pc,
        input [31:0] read_data1,
        input [31:0] label,
        input [4:0] fcode,
        input branch,
        input branchSrc,
        input sign,
        input zero,
        input carry,
        output [31:0] next_pc,
        output [31:0] writeRegData
    );
    // assign o = (i_sel)? i_a : i_b;
    wire [31:0] w1, w2, w3;
    wire w4, w5;
    wire t1, t2;
    
    Mux2To1 branchtype(.i_a(label), .i_b(read_data1), .i_sel(branchSrc), .o(w1));

    rca32 full_adder_1(.A(32'b100), .B(pc), .cin(1'b0), .S(w2), .cout(t1));

    rca32 full_adder_2(.A(w2), .B(w1), .cin(1'b0), .S(w3), .cout(t2));

    Mux6To1 mux_6to1(.i_a(~carry), .i_b(carry), .i_c(sign), .i_d(1'b1), .i_e(zero), .i_f(~zero), .i_sel(fcode), .o(w4));

    assign w5 = w4&branch;

    Mux2To1 mux_2to1(.i_a(w3), .i_b(w2), .i_sel(w5), .o(next_pc));

    assign writeRegData = w2;    
endmodule 
`endif //_BRANCH_