/*
Assignment 6
Problem no: 2
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/


module dff_struct(D, Clk, Reset, Q);
	input D, Clk, Reset;
	output reg Q;
	
    // data transfer at positive edge
    always @(posedge Clk or posedge Reset)
        begin
            if(Reset)
                Q <= 1'b0;
            else
                Q <= D;
        end
endmodule