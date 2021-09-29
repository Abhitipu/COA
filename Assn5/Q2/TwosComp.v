/*
Assignment 5
Problem no: 2
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ps

module TwosComp(
        input reset,
        input bit,
        input clk,
        output reg res
    );
    
    wire ps, ns;
    assign ns = bit | ps; // next state logic
    dff_struct dff(ns, clk, reset, ps);  // to store the state
    always @(*) res = ps ^ bit; // output logic

endmodule 

// state  encoding description
// A        0           Have not seen 1
// B        1           have seen 1
// NS  Logic 
// PS\Input
//    0   1
// 0  0   1
// 1  1   1
// NS = Input + PS = Input or PS

// Output Logic
// Ps\Input
//    0   1
// 0  0   1  
// 1  1   0
// output = Input*PS' + Input'*PS = Input xor PS