/*
Assignment 1
Problem no: 1c/1d
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns
`include "RippleCarryAdder.v"

module RippleCarryAdder_tb;
    reg[3:0] a4,b4;
    reg cin4;
    wire cout4;
    wire [3:0] sum4;
    rca4 rca_4(a4,b4,cin4,sum4,cout4);

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

    reg[15:0] a16,b16;
    reg cin16;
    wire cout16;
    wire [15:0] sum16;
    rca16 rca_16(a16,b16,cin16,sum16,cout16);

    reg[31:0] a32,b32;
    reg cin32;
    wire cout32;
    wire [31:0] sum32;
    rca32 rca_32(a32,b32,cin32,sum32,cout32);

    reg[63:0] a64,b64;
    reg cin64;
    wire cout64;
    wire [63:0] sum64;
    rca64 rca_64(a64,b64,cin64,sum64,cout64);

    initial begin
        $dumpfile("RippleCarryAdder_tb.vcd");
        $dumpvars(0,RippleCarryAdder_tb);


        a4=4'b1010;b4=4'b0011;cin4=0;
        a8=8'b10001010;b8=8'b00100011;cin8=1;
        as8=8'b10001010;bs8=8'b00100011;cins8=1;
        a16 = 16'b0001111011111010; b16 = 16'b0011111111111100;cin16=1;
        a32 = 32'b10011110111110100011111111111100; b32 = 32'b 11100010010000000010100111011011; cin32 = 0;
        a64 = 64'b0011101000110110010001100011010001001011000000000001010111010111; 
        b64 = 64'b1101011010000110010110001010100110010001010000111000000001000111;
        cin64 = 0;
        #20;

        a4=4'b1011;b4=4'b0111;cin4=0;
        a8<=8'b01000010;b8<=a8;cin8=0;
        as8<=8'b01000010;bs8<=a8;cins8=0;
        a16 = 16'b0101100001011010 ; b16 = 16'b1110100001110010;cin16=0;
        a32 = 32'b01101000100100111101011110010010; b32 = 32'b00101001001111001011011100110010; cin32 = 1;
        a64 = 64'b0110110111001100110000001100100010111110001111100000000111101110; 
        b64 = 64'b1110001100101010000110011111011001111101100011010100110000011010;
        cin64 = 1;
        #20;

        a4=4'b1110;b4=4'b1001;cin4=1;
        a8<=8'b10011111;b8<=8'b11000010;cin8=1;
        as8<=8'b10011111;bs8<=8'b11000010;cins8=1;
        a16 = 16'b0011000011001101; b16 = 16'b1001111111110011;cin16=0;
        a32 = 32'b 11010011001011100001101101101000; b32 = 32'b 10011111100011100011100110100100; cin32 = 1;
        a64 = 64'b1001001101010110101110101001001110010001011000000110001100111110; 
        b64 = 64'b0000000011011010100110100010100110001000000111010010101001101101;
        cin64 = 1;
        #20;

        
        $display("end of test.");
    end

endmodule
