/*
Assignment 6
Problem no:3 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`include "FullAdder.v"
module rca8(A, B, cin, S, cout);
    input[7:0] A, B;
    input cin;
    output[7:0] S;
    output cout;

    // 8 instantiated 1-bit full adders
    wire[7:0] c;
    assign c[0] = cin;
    FA_Struct fa[7:0](A, B, c, {cout, c[7:1]}, S);

endmodule

module rcas8 (A, B, mode, S, cout);
    input [7:0] A, B;
    input mode;
    output [7:0] S;
    output cout;

    wire[7:0] BXOR;
    xor u[7:0] (BXOR, mode, B); 
    rca8 R1(A, BXOR, mode, S, cout);

endmodule