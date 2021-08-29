`timescale 1ns/1ns
`include "CarryLookAheadAdder16BitRipple.v"

module CLA16_tb;
    reg[15:0] A, B;
    reg C0;
    wire[15:0] Sum;
    wire Cout;

    CLA16Ripple cla16r(A, B, C0, Sum, Cout);

    initial begin
        $dumpfile("CarryLookAheadAdder16BitRipple_tb.vcd");
        $dumpvars(0,CLA16_tb);

        A <= 16'b1010001110101100; B <= 16'b0011010111001100; C0 <= 0; #10;
        A <= 16'b1010111110001100; B <= 16'b0011100111111000; C0 <= 0; #10;
        A <= 16'b1110100111100100; B <= 16'b1000000000000000; C0 <= 0; #10;
        A <= 16'b1000100100100111; B <= 16'b1011001001111001; C0 <= 0; #10;
        A <= 16'b1110100101001001; B <= 16'b1001100111001100; C0 <= 1; #10;
        A <= 16'b1101101001001001; B <= 16'b1011100010010111; C0 <= 1; #10;
        A <= 16'b0000000000000000; B <= 16'b1111111111111111; C0 <= 1; #10;
        A <= 16'b0101100010011100; B <= 16'b1000110010011100; C0 <= 1; #10;

        $display("End of test for 16 bit ripple carry look ahead adder.");
    end
endmodule