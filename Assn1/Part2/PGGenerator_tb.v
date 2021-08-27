`timescale 1ns/1ns
`include "PGGenerator.v"

module PGGenerator_tb;

    reg[3:0] A, B;
    wire[3:0] P, G;

    PG_Generator pggen(A, B, P, G);
    
    initial begin
        $dumpfile("PGGenerator_tb.vcd");
        $dumpvars(0,PGGenerator_tb);
        
        A <= 4'b0101; B <= 4'b0101; #20;
        A <= 4'b1100; B <= 4'b1111; #20;
        A <= 4'b1111; B <= 4'b0000; #20;
        
        $display("end of test for propagate and generate module.");
    end

endmodule
