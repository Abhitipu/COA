`timescale 1ns/1ns
`include "dff.v"



module dff_tb;
reg d,clk,preset_bar, clear_bar;
wire Q,Qn;
d_flip_flop_edge_triggered dff(d,clk,Q,Qn,preset_bar,clear_bar);

initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("dff_tb.vcd");
    $dumpvars(0,dff_tb);

    d=1;preset_bar=0;clear_bar=1;#13;
    d=1;preset_bar=1;clear_bar=0;#13;
    preset_bar=1;clear_bar=1;#1;
    d=0;#13;
    d=1;#13;
    d=0;#13;



    
    $display("end of test.");
    $finish;
end

endmodule
