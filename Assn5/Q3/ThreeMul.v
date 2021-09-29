/*
Assignment 5
Problem no: 3
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ps

module ThreeMul(
        input reset,
        input bit,
        input clk,
        output reg res
    );
    
    wire[1:0] ps, ns;

    assign ns[1] = ps[1] & bit | (~bit) & (~ps[1]) & ps[0];
    assign ns[0] = ps[1] | (~ps[0])&bit;

    dff_struct dff0(ns[0], clk, reset, ps[0]);  
    dff_struct dff1(ns[1], clk, reset, ps[1]); 

    always @(*) res = (~ps[1])&(~ps[0])&(~bit) | (~ps[1])&ps[0]&bit;

endmodule

// state  encoding description
//          s1 s0  
// Q0        0 0           0 mod 3
// Q1        0 1           1 mod 3
// Q2        1 x           2 mod 3

// NS1  Logic 
// PS1 PS0\Input
//          0   1
// 0   0    0   0
// 0   1    1   0
// 1   1    0   1
// 1   0    0   1
// NS1 = PS1 * Input + Input' * PS1' * PS0

// NS0  Logic 
// PS1 PS0\Input
//          0   1
// 0   0    0   1
// 0   1    x   0
// 1   1    1   x
// 1   0    1   x
// NS0 = PS1 + PS0' * INPUT


// Output Logic(1 means divisible by 3)
// PS1 PS0\Input
//          0   1
// 0   0    1   0
// 0   1    0   1
// 1   1    0   0
// 1   0    0   0
// output = PS1' * PS0' * Input' + PS1' * PS0 * Input