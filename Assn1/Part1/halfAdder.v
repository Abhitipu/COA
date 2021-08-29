/*
Assignment 1
Problem no: 1a 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns
`ifndef _HA_v_
`define _HA_v_

module halfAdder (a, b, sum, cout);
    input a,b;              // inputs
    output sum,cout;        // outputs

    // Combinational logic
    assign cout = a&b;   
    assign sum = a^b;
endmodule

`endif // _HA_v_