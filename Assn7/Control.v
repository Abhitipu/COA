/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _CONTROL_
`define _CONTROL_
module Control(
    input [4:0] opCode,
    output reg WriteData,
    output reg [1:0] Branch,
    output reg MemWrite,
    output reg MemReg,
    output reg MemRead,
    output reg [1:0] AluOp,
    output reg [1:0] AluSrc,
    output reg RegWrite,
    output reg [1:0] RegDest
);
//  All dont cares have been replaced by 0
    always @(opCode) begin
        case (opCode)
            0: begin
                // R type
                WriteData = 1'b0;
                Branch = 2'b0;
                MemWrite = 1'b0;
                MemReg = 1'b0;
                MemRead = 1'b0;
                AluOp = 2'b01;
                AluSrc = 2'b00;
                RegWrite = 1'b1;
                RegDest = 2'b00;
            end
            1: begin
                // Shift with sh type
                WriteData = 1'b0;
                Branch = 2'b0;
                MemWrite = 1'b0;
                MemReg = 1'b0;
                MemRead = 1'b0;
                AluOp = 2'b01;
                AluSrc = 2'b11;
                RegWrite = 1'b1;
                RegDest = 2'b00;
            end
            2: begin
                // Load word type
                WriteData = 1'b0;
                AluSrc = 2'b01;
                MemReg = 1'b1;
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                Branch = 2'b00;
                AluOp = 2'b00;
                RegDest = 2'b01;
            end

            3: begin
                // Store word type
                WriteData = 1'b0;
                AluSrc = 2'b01;
                MemReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                Branch = 2'b00;
                AluOp = 2'b00;
                RegDest = 2'b00;
            end

            4: begin
                // Addi type
                WriteData = 1'b0;
                AluSrc = 2'b01;
                MemReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 2'b00;
                AluOp = 2'b00;
                RegDest = 2'b00;
            end
            5: begin
                // compi type
                WriteData = 1'b0;
                AluSrc = 2'b01;
                MemReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 2'b00;
                AluOp = 2'b10;
                RegDest = 2'b00;
            end 
            6: begin
                // branch bcy, bncy, b type
                WriteData = 1'b0;
                AluSrc = 2'b00;
                MemReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 2'b11;
                AluOp = 2'b00;
                RegDest = 2'b00;
            end  
            default: AluControlLine = 4'b0;
        endcase
    end

endmodule 
`endif //_CONTROL_