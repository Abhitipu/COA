/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _ALUC_
`define _ALUC_
module ALU_control(
    input [1:0] AluOp,
    input [4:0] FuncCode,
    output reg[3:0] AluControlLine
);

    always @(*) begin
        case (AluOp)
            0:  AluControlLine = 4'b0000;
            1:  AluControlLine = {FuncCode[3:0]};
            2:  AluControlLine = 4'b0001;
            default: AluControlLine = 4'b0000;
        endcase
    end

endmodule 
`endif //_ALUC_