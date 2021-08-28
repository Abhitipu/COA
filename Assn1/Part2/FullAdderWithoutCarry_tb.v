`timescale 1ns/1ns
`include "FullAdderWithoutCarry.v"

module FullAdderWithoutCarry_tb;
    reg p,cin;
    wire sum;
    FA_Struct FA(p,cin,sum);

    initial begin
        $dumpfile("FullAdderWithoutCarry_tb.vcd");
        $dumpvars(0,FullAdderWithoutCarry_tb);

        p=0;cin=0;#10;
        p=0;cin=1;#10;
        p=0;cin=0;#10;
        p=0;cin=1;#10;
        p=1;cin=0;#10;
        p=1;cin=1;#10;
        p=1;cin=0;#10;
        p=1;cin=1;#10;
        
        $display("Full Adder without carry testing done.");
    end

endmodule
