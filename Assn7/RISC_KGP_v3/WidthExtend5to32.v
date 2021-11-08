/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/


module WidthExtend5to32(input [4:0] in, output [31:0] out);
    assign out = {27'b0, in};
endmodule