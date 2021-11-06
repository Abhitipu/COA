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
module RightShift (
            input[31:0] A,
            input[31:0] B, 
            output[31:0] RightShifted_A
            );
    reg [4:1] shamt;
    reg mode = 1;
    reg cin = 0;
    reg[31:0] BarrelOut;
    BarrelShifter b1(.in(A), .shamt(shamt), .dir(1'b0),.feedinbit(1'b0) .out(BarrelOut));
    always @(*) begin
        if( B > 31)
            begin
                RightShifted_A <= 0;
            end
        else
            begin
                shamt <= B[4:0];
                RightShifted_A <= BarrelOut;
            end
    end
endmodule