`timescale 1ns/1ns
`include "workingRegister.v"



module workingRegister_tb;

reg serial_in,clear_bar,preset_bar,clk;
wire [3:0] parallel_out;
wire carry;

workingRegister WR(serial_in,preset_bar,clear_bar,clk,parallel_out,carry);
initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("workingRegister_tb.vcd");
    $dumpvars(0,workingRegister_tb);
    preset_bar=1;clear_bar=0;serial_in=0;#20;
    serial_in=1;preset_bar=1;clear_bar=1;#20;
    serial_in=0;#10;
    serial_in=1;#10;
    #40;
    $display("end of test.");
    $finish;

end

endmodule
