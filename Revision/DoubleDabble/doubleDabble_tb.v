`timescale 1ns/1ns
`include "doubleDabble.v"



module doubleDabble_tb;

reg serial_in,mode,clear_bar,preset_bar,clk;
reg[7:0] parallel_in;
wire [3:0] parallel_out_d0, parallel_out_d1, parallel_out_d2;
wire serial_out;

doubleDabble8bit dbdbb(serial_out, preset_bar, clear_bar, clk, parallel_out_d0, parallel_out_d1,parallel_out_d2);
InputRegister IR(parallel_in,serial_in, mode, preset_bar, clear_bar, clk, serial_out);
initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("doubleDabble_tb.vcd");
    $dumpvars(0,doubleDabble_tb);

    // Note : first apply preset = 1 and clear = 0 to initialize for say two clock cycle
    
    // Testcase 1
    preset_bar=1;clear_bar=0;serial_in=0;mode=1;parallel_in=8'b10110011;#20;

    //now we may start our experiment
    preset_bar=1;clear_bar=1;mode=0;

    //we need 8 clock cycles 10*8
    #90;
    
    // Testcase 2
    //loading data on input register
    preset_bar=1;clear_bar=0;serial_in=0;mode=1;parallel_in=8'b00010001;#20;
    //data feeded serially to double dabble
    preset_bar=1;clear_bar=1;mode=0;
    
    #90;

    // Testcase 3
    //loading data on input register
    preset_bar=1;clear_bar=0;serial_in=0;mode=1;parallel_in=8'b10101010;#20;
    //data feeded serially to double dabble
    preset_bar=1;clear_bar=1;mode=0;
    #90;
    $display("end of test.");
    $finish;

end

endmodule
