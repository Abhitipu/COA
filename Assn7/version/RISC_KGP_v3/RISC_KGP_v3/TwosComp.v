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
module TwosComp (
            input[31:0] B, 
            output[31:0] TwosCompOut
            );

    reg cin = 0;

    wire[31:0] BXOR;
    xor u[31:0] (BXOR, 32'b11111111111111111111111111111111, B);
    
    wire cout;
    // Ripple Carry adder and Subtractor, made by mimicking 2s Complement on B
    rca32 R1(32'b0, BXOR, 1'b1, TwosCompOut, cout);

endmodule