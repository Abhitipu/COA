/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`include "BarrelShifter.v"
`include "Adder.v"
module RightShiftArithmetic (
            input[31:0] A,
            input[31:0] B, 
            output[31:0] RightShiftedArithmetic_A
            );
    reg [4:1] shamt;
    reg mode = 1;
    reg cin = 0;
    reg[31:0] BarrelOut;
    BarrelShifter b1(.in(A), .shamt(shamt), .dir(1'b0), .feedinbit(A[31]), .out(BarrelOut));
    
    // module rca32(A, B, cin, S, cout);
    always @(*) begin
        if(B > 31)
            begin
                RightShiftedArithmetic_A <= {32{A[31]}};
            end
        else
            begin
                shamt <= B[4:0];
                RightShiftedArithmetic_A <= BarrelOut;
            end
    end
endmodule