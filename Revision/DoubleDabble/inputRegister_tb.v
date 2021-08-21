`timescale 1ns/1ns
`include "inputRegister.v"



module inputRegister_tb;
reg [7:0] parallel_in;
reg serial_in,clear_bar,preset_bar,mode,clk;
wire serial_out;

InputRegister IR(parallel_in,serial_in,mode,preset_bar,clear_bar,clk,serial_out);
initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("inputRegister_tb.vcd");
    $dumpvars(0,inputRegister_tb);
    parallel_in=8'b10101111;serial_in=0;mode=1;preset_bar=1;clear_bar=1;#20;
    mode=0;#40;
    serial_in=1;#40;
    serial_in=0;#40;

    
    $display("end of test.");
    $finish;

end

endmodule
