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
    shift_register Ain(.parallelIn(A), .serialIn(1'b 0) , .mode(mode), .dir(1'b0), .reset(reset), .clk(clk), .serialOut(Abit)); // Abit = serial out of right shift of A
    shift_register Bin(.parallelIn(B), .serialIn(1'b 0) , .mode(mode), .dir(1'b0), .reset(reset), .clk(clk), .serialOut(Bbit)); // Bbit = serial out of right shift of B
    
    shift_register Sout(.parallelIn(8'b00000000), .serialIn(Sbit), .mode(mode), .dir(1'b0), .reset(reset), .clk(clk), .serialOut(), .state(SumWire)); // serial in is Sbit
    // shift_register Sout(8'b00000000, Sbit, mode,1'b0, reset, clk, CoutWire, SumWire); // right shift, here
    FA_Struct fa1(Abit, Bbit, Cbit, cobit, Sbit); // Full adder that calulates Sbit and CoutBit
    dff_struct dff1(cobit, clk, reset, Cbit);     // dff stores previous cycle Carry bit
    always @(*) begin
        Sum <= SumWire;                           // non blocking Sum assignment
        Cout <=Sbit;                              // Sbit is the bit that goes to Sout in the next cycle, hence indirectly it will be 9th bit in the 8th clock cycle
    end


endmodule
// understanding the clock cycles
// Say the Ain and Bin are load and we start our shift operation
// then during the first cycle of clock, Abit and Bbit will be loaded, hence Cobit and Sbit gets computed
// in the second cycle of clock, 2nd bit will load onto Abit and Bbit, last sbit would have been pushed into Sout and new Sbit and cobit will be computed.
// Hence at kth cycle of clock, k-1 th bits are loaded onto Sout, so after shifting starts it will take n + 1 cycles of clock(n is number of bits) to compute sum