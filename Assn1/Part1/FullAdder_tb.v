`timescale 1ns/1ns
`include "FullAdder.v"



module FullAdder_tb;
reg a,b,cin;
wire sum,cout;
FA_Struct FA(a,b,cin,cout,sum);

initial begin
    $dumpfile("FullAdder_tb.vcd");
    $dumpvars(0,FullAdder_tb);


    a=0;b=0;cin=0;#20;
    a=0;b=0;cin=1;#20;
    a=0;b=1;cin=0;#20;
    a=0;b=1;cin=1;#20;
    a=1;b=0;cin=0;#20;
    a=1;b=0;cin=1;#20;
    a=1;b=1;cin=0;#20;
    a=1;b=1;cin=1;#20;
    
    $display("end of test.");
end

endmodule
