/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _FA_v_
`define _FA_v_
module FA_Struct(a, b, cin, cout, sum);
    input  a, b, cin;      // inputs
    output cout, sum;      // output

    // Combinational logic
    assign sum = a^b^cin;
    assign cout = (a&b) | ((a^b)&cin);
endmodule
`endif // _FA_v_