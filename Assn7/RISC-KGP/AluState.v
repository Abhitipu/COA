/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
module AluState (
            input carryin,
            input clk,
            output reg carryFlag
            );       
    always @(negedge clk) begin
        carryFlag <= carryin;
    end
endmodule