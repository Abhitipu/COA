/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
module XOR (
            input[31:0] A, 
            input[31:0] B,
            output[31:0] Xor_out
            );

    assign Xor_out = A ^ B;
endmodule