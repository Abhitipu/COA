/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _REG_
`define _REG_

module Register(
        input[31:0] writeToReg,
        input enable,
        input clk,
        input reset,
        output reg [31:0] data
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= 32'b0;
        end else begin
            if (enable) begin
                data <= writeToReg;
            end
        end
    end
    

endmodule 
`endif //_REG_