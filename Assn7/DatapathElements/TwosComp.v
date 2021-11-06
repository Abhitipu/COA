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

    reg mode = 1;
    reg cin = 0;

    wire[7:0] BXOR;
    xor u[7:0] (BXOR, mode, B);
    
    wire cout;
    // Ripple Carry adder and Subtractor, made by mimicking 2s Complement on B
    rca32 R1(32'b0, BXOR, mode, TwosCompOut, cout);

endmodule