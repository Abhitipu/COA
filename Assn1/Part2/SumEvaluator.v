/*
Assignment 1
Problem no: 2b
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`timescale 1ns/1ns
`ifndef _SE_v_
`define _SE_v_

module SE(p, cin, sum);

    input[3:0]  p, cin;
    output[3:0] sum;
    // Evaluates sum using p and cin , since p is already a^b
    assign sum = p^cin;

endmodule

`endif  // _SE_v_