/*
Assignment 6
Problem no: 3
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns
`include "AdderSub.v"

module AdderSub_tb;
  
    reg[7:0] a8,b8;
    reg cin8;
    wire cout8;
    wire [7:0] sum8;
    rca8 rca_8(a8,b8,cin8,sum8,cout8);

    reg[7:0] as8,bs8;
    reg cins8;
    wire couts8;
    wire [7:0] sums8;
    rcas8 rcas_8(as8,bs8,cins8,sums8,couts8);

    initial begin
        $dumpfile("AdderSub_tb.vcd");
        $dumpvars(0,AdderSub_tb);


        a8=8'b10001010;b8=8'b00100011;cin8=1;
        as8=8'b10001010;bs8=8'b00100011;cins8=1;
        #20;

        
        a8<=8'b01000010;b8<=a8;cin8=0;
        as8<=8'b01000010;bs8<=a8;cins8=0;
        #20;

        a8<=8'b10011111;b8<=8'b11000010;cin8=1;
        as8<=8'b10011111;bs8<=8'b11000010;cins8=1;
        #20;

        $display("end of test.");
    end

endmodule
