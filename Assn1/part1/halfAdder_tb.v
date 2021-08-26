`timescale 1ns/1ns

`include "halfAdder.v"

module halfAdder_tb;

reg A, B;
wire S, C;

halfAdder HA (A, B, S, C);

initial begin
    $dumpfile("halfAdder_tb.vcd");
    $dumpvars(0, halfAdder_tb);
    A = 0; B = 0; #20;
    A = 0; B = 1; #20;
    A = 1; B = 0; #20;
    A = 1; B = 1; #20;
    
end
    
endmodule