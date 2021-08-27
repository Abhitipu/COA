`timescale 1ns/1ns
`include "FullAdderWithoutCarry.v"

module FullAdderWithoutCarry_tb;
    reg a,b,cin;
    wire sum;
    FA_Struct FA(a,b,cin,sum);

    initial begin
        $dumpfile("FullAdderWithoutCarry_tb.vcd");
        $dumpvars(0,FullAdderWithoutCarry_tb);

        a=0;b=0;cin=0;#10;
        a=0;b=0;cin=1;#10;
        a=0;b=1;cin=0;#10;
        a=0;b=1;cin=1;#10;
        a=1;b=0;cin=0;#10;
        a=1;b=0;cin=1;#10;
        a=1;b=1;cin=0;#10;
        a=1;b=1;cin=1;#10;
        
        $display("Full Adder without carry testing done.");
    end

endmodule
