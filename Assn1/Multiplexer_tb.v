`timescale 1ns/1ns
`include "Multiplexer.v"

module Multiplexer_tb;
reg x,u,v;
wire z;

multiplexer_struct mux(x,u,v,z);

initial begin
    $dumpfile("Multiplexer_tb.vcd");
    $dumpvars(0,Multiplexer_tb);

    x=1;u=0;v=0;#20;
    x=1;u=1;v=0;#20;
    x=1;#20;
    x=0;#20;
    $display("end of test.");
end

endmodule
