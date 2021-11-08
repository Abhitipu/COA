/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
TODO ALU RESET line
*/

`include "ProgramCounter.v"
`include "RegisterFile.v"
`include "ALU.v"
`include "ControlUnit.v"
`include "SignExtend17To32.v"
`include "WidthExtend5to32.v"
`include "MultiplexerThreeToOne.v"
`include "ALUControl.v"
`include "Branching.v"
`include "MultiplexerTwoToOne.v"

module risc_kgp(
        input clk,
        input reset
    );

    wire[31:0] next_pc, curr_pc;
    ProgramCounter pc(.in(next_pc), 
                    .clk(clk), 
                    .out(curr_pc));
    
    wire[31:0] instr;
    InstructionMemory im(.clka(clk), 
                        .ena(1'b1), 
                        .addra(curr_pc), 
                        .douta(instr));
    
    // Control Lines
    wire WriteData;
    wire[1:0] Branch;
    wire MemWrite, MemReg, MemRead;
    wire[1:0] AluOp, AluSrc;
    wire RegWrite;
    wire[1:0] RegDest;

    ControlUnit cu(.opCode(instr[31:27]), 
                .WriteData(WriteData), 
                .Branch(Branch), 
                .MemWrite(MemWrite), 
                .MemReg(MemReg), 
                .MemRead(MemRead), 
                .AluOp(AluOp), 
                .AluSrc(AluSrc), 
                .RegWrite(RegWrite), 
                .RegDest(RegDest) );

    wire[4:0] write_reg_source;
    Mux3To1_5 mux3to1_5(
                    .i_a(instr[26:22]), 
                    .i_b(instr[21:17]), 
                    .i_c(5'b11111), 
                    .i_sel(RegDest), 
                    .o(write_reg_source));

    wire[31:0] read_data1, read_data2;
    RegisterFile rf(.reg_write(RegWrite), 
                    .clk(clk), .reset(reset), 
                    .read_register1(instr[26:22]), 
                    .read_register2(instr[21:17]), 
                    .write_register(write_reg_source), 
                    .write_data(), 
                    .read_data1(read_data1), 
                    .read_data2(read_data2));

    wire[3:0] ALUControlLine;
    ALUControl aluc(.AluOp(AluOp), 
                    .FuncCode(instr[11:7]), 
                    .AluControlLine(AluControlLine));
    
    // module WidthExtend5to32(input [4:0] in, output [31:0] out);
    wire[31:0] extendedOutput1;
    WidthExtend5to32 we5to32(.in(instr[16:12]), .out(extendedOutput1));
    // module SignExtend17to32(input [17:0] in, output [31:0] out);
    wire[31:0] extendedOutput2;
    SignExtend17To32 se17to32(.in(instr[16:0]), .out(extendedOutput2));
    
    wire[31:0] AluInput2;
    Mux3To1_32 mux3to1_32(.i_a(read_data2), 
                            .i_b(extendedOutput2), 
                            .i_c(extendedOutput1), 
                            .i_sel(AluSrc), 
                            .o(AluInput2));

    wire[31:0] ALUResult;
    wire sign, carry, zero;
    ALU alu(.A(read_data1), 
            .B(AluInput2), 
            .Sel(AluControlLine), 
            .clk(clk), 
            .result(ALUResult), 
            .sign(sign), 
            .carry(carry), 
            .zero(zero));
    // brach datamem
    MultiplexerTwoToOne mux2to1();
    Branching branching();

endmodule