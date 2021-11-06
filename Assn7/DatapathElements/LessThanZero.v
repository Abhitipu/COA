/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
module LessThanZero (
            input[31:0] A, 
            output LessThanZeroFlag
            );

    assign LessThanZeroFlag = (A[31] == 1) ? 1'b1 : 1'b0;
endmodule