/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _PC_
`define _PC_
module ProgramCounter(
        input[31:0] in,
        input clk,
		  input reset,
        output reg [31:0] out
    );

    always @(posedge clk or posedge reset) begin
			if (reset) begin
				out <= 32'b0;
			end
			else begin
				out <= in;
			end
	 end
endmodule 
`endif //_PC_