`timescale 1ns/1ns
`include "CarryForwardGeneratorBlock.v"

module CarryForwardGeneratorBlock_tb;
    
    reg [3:0] P, G;
    reg  C;
    wire[3:0] Cout;

    Carry_Forward_Generator16Block cg(P, G, C, Cout);

    initial begin
        $dumpfile("CarryForwardGeneratorBlock_tb.vcd");
        $dumpvars(0,CarryForwardGeneratorBlock_tb);

        P <= 4'b1110; G <= 4'b0111; C <= 0; #10;
        P <= 4'b1001; G <= 4'b1101; C <= 0; #10;
        P <= 4'b0110; G <= 4'b1100; C <= 1; #10;
        P <= 4'b0111; G <= 4'b1110; C <= 1; #10;

        $display("Carry Generator Block testing done.");
    end

endmodule