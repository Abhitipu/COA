/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
module EqualToZero (
            input[31:0] A, 
            output ZeroFlag
            );

    assign ZeroFlag = (A == 32'b0) ? 1'b1 : 1'b0;
endmodule