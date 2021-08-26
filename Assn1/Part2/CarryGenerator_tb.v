`timescale 1ns/1ns
`include "CarryGenerator.v"

module CarryGenerator_tb;
    
    reg [3:0] A, B;
    reg  C;
    wire[3:0] Cout;

    Carry_Forward_Generator cg(A, B, C, Cout);

    initial begin
        $dumpfile("CarryGenerator_tb.vcd");
        $dumpvars(0,CarryGenerator_tb);

        A <= 4'b1110; B <= 4'b0111; C <= 0; #10;
        A <= 4'b1001; B <= 4'b1101; C <= 0; #10;
        A <= 4'b0110; B <= 4'b1100; C <= 1; #10;
        A <= 4'b0111; B <= 4'b1110; C <= 1; #10;

        $display("Carry Generator testing done.");
    end

endmodule