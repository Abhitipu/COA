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
`include "TwosComp.v"
`include "AND.v"
`include "XOR.v"
`include "LeftShift.v"
`include "RightShift.v"
`include "RightShiftArithmetic.v"
`include "LessThanZero.v"
`include "EqualToZero.v"
`include "AluState.v"
`include "MuxSevenToOne.v"

module ALU (
            input[31:0] A,
            input[31:0] B,
            input[3:0] Sel,
            input clk, 
            output[31:0] result,
            output sign,
            output carry,
            output zero
            );

    wire [31:0] Add_out, TwosComp_out, And_out, Xor_out, LeftShift_out, RightShift_out, RightShiftArr_out; 
    wire carryInternal;
    
    // instantiate Adder module
    rca32 adder(.A(A), .B(B), .cin(1'b0), .S(Add_out), .cout(carryInternal));
    // instantiate TwosComp module
    TwosComp twosComp(.B(B), .TwosCompOut(TwosComp_out));
    // instantiate AND module
    AND and1(.A(A), .B(B), .And_out(And_out));
    // instantiate XOR module
    XOR xor1(.A(A), .B(B), .Xor_out(Xor_out));
    
    // instantiate LeftShift module
    LeftShift leftShift(.A(A), .B(B), .LeftShifted_A(LeftShift_out));
    // instantiate RightShift module
    RightShift rightShift(.A(A), .B(B), .RightShifted_A(RightShift_out));
    // instantiate RightShiftArithmetic module
    RightShiftArithmetic rightShiftArithmetic(.A(A), .B(B), .RightShiftedArithmetic_A(RightShiftArr_out));
    
    // instantiate LessThanZero module
    LessThanZero lessThanZero(.A(A), .LessThanZeroFlag(sign));
    // instantiate EqualToZero module
    EqualToZero equalToZero(.A(A), .ZeroFlag(zero));
    
    // instantiate MuxSevenToOne module
    Mux7To1 muxSevenToOne(
        .i_a(Add_out),
        .i_b(TwosComp_out),
        .i_c(And_out),
        .i_d(Xor_out),
        .i_e(LeftShift_out),
        .i_f(RightShift_out),
        .i_g(RightShiftArr_out),
        .i_sel(Sel),
        .o(result)
    );

    AluState alustate(
        .carryin(carryInternal),
        .clk(clk),
        .carryFlag(carry)
    );

endmodule