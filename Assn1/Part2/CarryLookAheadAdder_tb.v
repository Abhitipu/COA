`timescale 1ns/1ns
`include "CarryLookAheadAdder.v"

module CarryLookAheadAdder_tb;
    
    reg [3:0] A, B;
    reg C0;
    wire[3:0] Sum, Carry;

    CLA cla(A, B, C0, Carry, Sum);

    initial begin
        $dumpfile("CarryLookAheadAdder_tb.vcd");
        $dumpvars(0,CarryLookAheadAdder_tb);

        A <= 4'b1010; B <= 4'b0011; C0 <= 0; #10;
        A <= 4'b1010; B <= 4'b0011; C0 <= 0; #10;
        A <= 4'b1110; B <= 4'b1000; C0 <= 0; #10;
        A <= 4'b1000; B <= 4'b1011; C0 <= 0; #10;
        A <= 4'b1110; B <= 4'b1001; C0 <= 1; #10;
        A <= 4'b1101; B <= 4'b1011; C0 <= 1; #10;
        A <= 4'b0000; B <= 4'b1111; C0 <= 1; #10;
        A <= 4'b0101; B <= 4'b1000; C0 <= 1; #10;

        $display("End of test for carry look ahead adder.");
    end

endmodule