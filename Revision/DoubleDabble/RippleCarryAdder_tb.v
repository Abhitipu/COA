`timescale 1ns/1ns
`include "RippleCarryAdder.v"



module RippleCarryAdder_tb;
reg[3:0] a,b;
reg cin;
wire cout;
wire [3:0] sum;
rca4 rca(a,b,cin,sum,cout);

initial begin
    $dumpfile("RippleCarryAdder_tb.vcd");
    $dumpvars(0,RippleCarryAdder_tb);


    a<=4'b1000;b<=4'b1010;cin<=1;#20;
    a<=4'b0100;b<=a;cin=0;#20;
    a=4'b0001;b=a;cin=1;#20;

    
    $display("end of test.");
end

endmodule
