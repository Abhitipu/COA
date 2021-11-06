/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`include "FullAdder.v"
`ifndef _ADDER_v_
`define _ADDER_v_
module rca32(A, B, cin, S, cout);
    // inputs
    input[31:0] A, B;
    input cin;
    // outputs
    output[31:0] S;
    output cout;

    // 31 instantiated 1-bit full adders and cascaded to form Ripple Carry Adder
    wire[31:0] c;
    assign c[0] = cin;
    FA_Struct fa[31:0](A, B, c, {cout, c[31:1]}, S);

endmodule 
`endif //_ADDER_v_