/*
Assignment 6
Problem no: 2
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`include "ShiftRegister.v"
`include "FullAdder.v"
`include "Dff.v"
module BitSerialAdder(
        input[7:0] A,
        input[7:0] B,
        input clk,
        input mode,
        input reset,
        output reg[7:0] Sum,
        output reg Cout
    );
    wire[7:0] SumWire;
    wire Abit, Bbit, Sbit, Cbit, CoutWire, cobit;
    shift_register Ain(.parallelIn(A), .serialIn(1'b 0) , .mode(mode), .dir(1'b0), .reset(reset), .clk(clk), .serialOut(Abit));
    shift_register Bin(.parallelIn(B), .serialIn(1'b 0) , .mode(mode), .dir(1'b0), .reset(reset), .clk(clk), .serialOut(Bbit));
    
    shift_register Sout(8'b00000000, Sbit, mode,1'b0, reset, clk, CoutWire, SumWire);
    FA_Struct fa1(Abit, Bbit, Cbit, cobit, Sbit);
    dff_struct dff1(cobit, clk, reset, Cbit);
    always @(*) begin
        Sum <= SumWire;
        Cout <=CoutWire;
    end


endmodule