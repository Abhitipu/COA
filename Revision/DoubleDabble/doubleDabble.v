/*

*****Instructions*****
To compile : iverilog -o doubleDabble doubleDabble.v
To run: vvp doubleDabble
To analyse plots: gtkwave output.vcd

*****Structure*****
Modules:
1. Full Adder
2. Ripple Carry Adder
3. Multiplexer
4. Nibble Converter
5. DFF
6. Input Register (8 bit)
7. Working Register (4 bit) {has another working register unit as a subpart}
8. Double Dabble
9. Top Module

*****Testing***** 

First all the modules will be tested using individual test benches.
After that the double dabble algorithm will be tested.
The program will do exhaustive testing of all 8 bit numbers
It will display the input followed by the binary representation of the three output bits.

After successful completion it will print "End of test."

To analyse waveforms use 
gtkwave output.vcd

For analysing double dabble:

Stack these in order:
1. clock (clk)
2. parallel input (parallel_in)
3. d2
4. d1
5. d0

Optional : can put parallel input once again for simultaneous binary representation.

It might require some zoom in/out to get a full view of the plots.

*/

`timescale 1ns/1ns

// Full Adder

module FA_Struct(a, b, cin, cout, sum);
    input  a, b, cin;      // inputs
    output cout, sum;      // output
    wire   w1, w2, w3, w4; // internal nets

    xor U1 (w1, a, b);
    xor U2 (sum, w1, cin);
    and U3 (w2, a, b);
    and U4 (w3, a, cin);
    and U5 (w4, b, cin);
    or  U6 (cout, w2, w3, w4);

endmodule

/******************************************************************/

// Ripple Carry Adder

module rca4(A, B, cin1, S, cout1);
    input[3:0] A, B;
    input cin1;
    output[3:0] S;
    output cout1;

    wire c1, c2, c3;

    // 4 instantiated 1-bit full adders
    FA_Struct fa0 (A[0], B[0], cin1, c1, S[0]);
    FA_Struct fa1 (A[1], B[1], c1, c2, S[1]);
    FA_Struct fa2 (A[2], B[2], c2, c3, S[2]);
    FA_Struct fa3 (A[3], B[3], c3, cout1, S[3]);

endmodule

/******************************************************************/

// MUX

module multiplexer_struct(x , u , v , z);
	input x,u,v;
	output z;

	wire s0 , s1, x_bar; // internal nets
	// xu + x_bar.v
    not U1(x_bar, x);
	and U2(s0 , x , u);
	and U3(s1 , x_bar, v);
	or U4(z , s0 , s1);
endmodule

/******************************************************************/


// Nibble Converter (add 3 if >= 5)

module nibble_converter(in , out);
	input[3:0] in;
	output [3:0] out;

	wire cout1;
	// w3=x3 + x2(x0 + x1) : logic for >= 5

	wire w1 , w2 , w3;
	or U1(w1 , in[0] , in[1]);
	and U2(w2 , w1 , in[2]);
	or U3(w3 , w2 , in[3]);
	wire [3:0] temp;
    assign temp[0] = w3;
    assign temp[1] = w3;
    assign temp[2] = 1'b0;
    assign temp[3] = 1'b0;

	rca4 ra(in , temp, 1'b0 , out , cout1);

endmodule

/******************************************************************/

// Master slave DFF (negative edge triggered)

module d_flip_flop_edge_triggered(D, CLK, Q, Qn, Preset_Bar, Clear_Bar);
    output Q,Qn;
    input  CLK,Clear_Bar,Preset_Bar,D;


    wire   CLKn;   // Negated Clock
    wire   Dn;  // Input Negated D
    wire s1,s2,s3,s4,s5,s6; //Internal net
    not U1(CLKn, CLK);
    not U2(Dn, D);

    //master
    // level 1 circuit
    nand U3(s1, D, CLK);
    nand U4(s2, Dn, CLK);

    //level 2 circuit
    nand U5(s3, s1, s4, Preset_Bar);
    nand U6(s4, s2, s3, Clear_Bar);

    //slave
    //level 1 circuit
    nand U7(s5, s3, CLKn);
    nand U8(s6, s4, CLKn);

    //level 2 circuit
    nand U9(Q, s5, Qn);
    nand U10(Qn, s6, Q);

endmodule // d_flip_flop_edge_triggered negative

/******************************************************************/

// consists of 1 dff and 1 mux cascaded

module InputRegister_unit (
    parallel_in,
    serial_in,
    mode,
    preset_bar,
    clear_bar,
    clk,
    serial_out
);
    input parallel_in,serial_in,mode,preset_bar,clear_bar,clk;
    output serial_out;
    //mode 1 for parallel loading
    //mode 0 for serial in/out

    wire s1,s2,s3,s4; //internal net
    multiplexer_struct mux1 (mode , parallel_in , serial_in , s1);
    d_flip_flop_edge_triggered dff1(.D(s1), .CLK(clk), .Q(serial_out), .Qn(), .Preset_Bar(preset_bar), .Clear_Bar(clear_bar));

endmodule

/******************************************************************/

// The 8 bit register for feeding input initially

module InputRegister (
    parallel_in,    // parallel input of size 8 bit
    serial_in,      //serial_in
    mode,
    preset_bar,
    clear_bar,
    clk,
    serial_out
);
    input [7:0] parallel_in;
    input serial_in,mode,preset_bar,clear_bar,clk;
    output serial_out;
    //mode 1 for parallel loading
    //mode 0 for serial in/out

    wire[6:0] s; //internal net

    // 8 cascaded units for operation

    InputRegister_unit u0(parallel_in[0], serial_in, mode, preset_bar, clear_bar, clk, s[0]);
    InputRegister_unit u1(parallel_in[1], s[0], mode, preset_bar, clear_bar, clk, s[1]);
    InputRegister_unit u2(parallel_in[2], s[1], mode, preset_bar, clear_bar, clk, s[2]);
    InputRegister_unit u3(parallel_in[3], s[2], mode, preset_bar, clear_bar, clk, s[3]);
    InputRegister_unit u4(parallel_in[4], s[3], mode, preset_bar, clear_bar, clk, s[4]);
    InputRegister_unit u5(parallel_in[5], s[4], mode, preset_bar, clear_bar, clk, s[5]);
    InputRegister_unit u6(parallel_in[6], s[5], mode, preset_bar, clear_bar, clk, s[6]);
    InputRegister_unit u7(parallel_in[7], s[6], mode, preset_bar, clear_bar, clk, serial_out);

endmodule

/**********************************************************************/

// these represent the digits!

module workingRegister (
    serial_in,
    preset_bar,
    clear_bar,
    clk,
    parallel_out,
    carry
);
    input serial_in,clear_bar,preset_bar,clk;
    output carry;
    output [3:0] parallel_out;
    wire[3:0] ns;

    // 4 dffs for data transfer while performing left shift.

    d_flip_flop_edge_triggered dff0(.D(serial_in), .CLK(clk), .Q(parallel_out[0]), .Qn(), .Preset_Bar(preset_bar), .Clear_Bar(clear_bar));
    d_flip_flop_edge_triggered dff1(.D(ns[0]), .CLK(clk), .Q(parallel_out[1]), .Qn(), .Preset_Bar(preset_bar), .Clear_Bar(clear_bar));
    d_flip_flop_edge_triggered dff2(.D(ns[1]), .CLK(clk), .Q(parallel_out[2]), .Qn(), .Preset_Bar(preset_bar), .Clear_Bar(clear_bar));
    d_flip_flop_edge_triggered dff3(.D(ns[2]), .CLK(clk), .Q(parallel_out[3]), .Qn(), .Preset_Bar(preset_bar), .Clear_Bar(clear_bar));

    nibble_converter nb(parallel_out,ns);       // adds 3 if required
    assign carry = ns[3];                       

endmodule

/******************************************************************/

// This implements the actual double dabble algorithm.

module doubleDabble8bit (
    serial_in,
    preset_bar,
    clear_bar,
    clk,
    parallel_out_d0,
    parallel_out_d1,
    parallel_out_d2
);

    input serial_in,preset_bar,clear_bar,clk;
    output [3:0] parallel_out_d0, parallel_out_d1, parallel_out_d2;
    wire [2:0] carry;

    // 3 working registers for 3 digits in BCD representation.

    workingRegister wr0(serial_in,preset_bar,clear_bar,clk,parallel_out_d0,carry[0]);
    workingRegister wr1(carry[0],preset_bar,clear_bar,clk,parallel_out_d1,carry[1]);
    workingRegister wr2(carry[1],preset_bar,clear_bar,clk,parallel_out_d2,carry[2]);

endmodule

/******************************************************************/

module top();               // first instances are created for individual testing
    
    reg clk;
    integer delay;

    // for full adder.
    reg a_FA , b_FA ,cin_FA; 
	wire cout_FA,sum_FA;
	FA_Struct FA(a_FA,b_FA,cin_FA,cout_FA,sum_FA);

    // for ripple carry adder.
    reg[3:0] a_RCA,b_RCA;
    reg cin_RCA;
    wire cout_RCA;
    wire [3:0] sum_RCA;
    rca4 RCA(a_RCA,b_RCA,cin_RCA,sum_RCA,cout_RCA);

    // for multiplexer.
    reg x_MUX,u_MUX,v_MUX;
    wire z_MUX;
    multiplexer_struct MUX(x_MUX,u_MUX,v_MUX,z_MUX);

    // for nibble converter.
    reg [3:0] in_NC;
    wire [3:0] z_NC;
    nibble_converter NC(in_NC,z_NC);

    // for dff
    reg d_DFF,preset_bar_DFF, clear_bar_DFF;
    wire Q_DFF,Qn_DFF;
    d_flip_flop_edge_triggered DFF(d_DFF,clk,Q_DFF,Qn_DFF,preset_bar_DFF,clear_bar_DFF);

    // for input register.
    reg [7:0] parallel_in_IPR;
    reg serial_in_IPR,clear_bar_IPR,preset_bar_IPR,mode_IPR;
    wire serial_out_IPR;
    InputRegister IPR(parallel_in_IPR,serial_in_IPR,mode_IPR,preset_bar_IPR,clear_bar_IPR,clk,serial_out_IPR);
    
    // for double dabble (working registers)
    reg serial_in,mode,clear_bar,preset_bar;
    reg[7:0] parallel_in;

    wire [3:0] parallel_out_d0, parallel_out_d1, parallel_out_d2;
    wire serial_out;

    doubleDabble8bit dbdbb(serial_out, preset_bar, clear_bar, clk, parallel_out_d0, parallel_out_d1,parallel_out_d2);
    InputRegister IR(parallel_in,serial_in, mode, preset_bar, clear_bar, clk, serial_out);
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("output.vcd");                // our output file
        $dumpvars(0,top); 


    	//full adder test bench
        $display("\nFull adder testing");
        $monitor("a = %b,b = %b,cin = %b,cout = %b,sum = %b",a_FA,b_FA,cin_FA,cout_FA,sum_FA);
        #0 a_FA=1;b_FA=1;cin_FA=1;
        #2 a_FA=1;b_FA=0;cin_FA=1;
        #2 a_FA=0;b_FA=1;cin_FA=0;
        delay = (10 - ($time%10))%10;            // this delay ensures that the next module is started in sync with the clock
        #delay;

        // ripple carry adder test bench
        $display("\nRipple Carry Adder testing");
        $monitor("a = %b,b = %b,cin = %b,cout = %b,sum = %b",a_RCA,b_RCA,cin_RCA,cout_RCA,sum_RCA);
        a_RCA<=4'b1000;b_RCA<=4'b1010;cin_RCA<=1;#20;
        a_RCA<=4'b0100;b_RCA<=a_RCA;cin_RCA=0;#20;
        a_RCA=4'b0001;b_RCA=a_RCA;cin_RCA=1;#20;
        delay = (10 - ($time%10))%10;
        #delay;

        // Multiplexer test bench
        $display("\nMultiplexer test bench");
        $monitor("x = %b, u = %b, v = %b, z = %b", x_MUX, u_MUX, v_MUX, z_MUX);
        x_MUX=1;u_MUX=0;v_MUX=0;#20;
        x_MUX=1;u_MUX=1;v_MUX=0;#20;
        x_MUX=0;#20;
        delay = (10 - ($time%10))%10;
        #delay;

        // Nibble converter test bench.
        $display("\nNibble convertor test bench");
        $monitor("Input = %b, Output = %b", in_NC, z_NC);
        in_NC = 4'b0100;#20;
        in_NC = 4'b0101;#20;
        in_NC = 4'b0110;#20;
        in_NC = 4'b0000;#20;
        delay = (10 - ($time%10))%10;
        #delay;

        // DFF Test bench (negative edge occurs at multiples of 10)
        $display("\nDFF Test bench");
        $monitor("Time: %0d, d = %b, Q = %b, Q' = %b preset' = %b, clear' = %b", $time, d_DFF, Q_DFF, Qn_DFF, preset_bar_DFF, clear_bar_DFF);
        d_DFF = 1; preset_bar_DFF=0; clear_bar_DFF=1;#13;
        d_DFF = 0;#13;

        d_DFF = 1;preset_bar_DFF=1;clear_bar_DFF=0;#13;
        d_DFF = 0;#13;

        preset_bar_DFF = 1; clear_bar_DFF = 1 ; d_DFF=1;#13;
        d_DFF = 0;#13;
        delay = (10 - ($time%10))%10;
        #delay;

        // Input Register test bench.
        $display("\nInput register test bench");
        
        parallel_in_IPR=8'b10101111;serial_in_IPR=0;mode_IPR=1;preset_bar_IPR=1;clear_bar_IPR=1;#20;
        mode_IPR=0;#10;

        $display("Time = %0d, Parallel input = %b, Mode = %b, Serial input = %b, Serial Output = %b", $time, parallel_in_IPR, mode_IPR, serial_in_IPR, serial_out_IPR);#10;
        $display("Time = %0d, Parallel input = %b, Mode = %b, Serial input = %b, Serial Output = %b", $time, parallel_in_IPR, mode_IPR, serial_in_IPR, serial_out_IPR);#10;
        $display("Time = %0d, Parallel input = %b, Mode = %b, Serial input = %b, Serial Output = %b", $time, parallel_in_IPR, mode_IPR, serial_in_IPR, serial_out_IPR);#10;
        $display("Time = %0d, Parallel input = %b, Mode = %b, Serial input = %b, Serial Output = %b", $time, parallel_in_IPR, mode_IPR, serial_in_IPR, serial_out_IPR);#10;
        $display("Time = %0d, Parallel input = %b, Mode = %b, Serial input = %b, Serial Output = %b", $time, parallel_in_IPR, mode_IPR, serial_in_IPR, serial_out_IPR);#10;
        $display("Time = %0d, Parallel input = %b, Mode = %b, Serial input = %b, Serial Output = %b", $time, parallel_in_IPR, mode_IPR, serial_in_IPR, serial_out_IPR);#10;
        $display("Time = %0d, Parallel input = %b, Mode = %b, Serial input = %b, Serial Output = %b", $time, parallel_in_IPR, mode_IPR, serial_in_IPR, serial_out_IPR);#10;
        $display("Time = %0d, Parallel input = %b, Mode = %b, Serial input = %b, Serial Output = %b", $time, parallel_in_IPR, mode_IPR, serial_in_IPR, serial_out_IPR);#10;

        delay = (10 - ($time%10))%10;
        #delay;

        // double dabble testing
        // Note : first apply preset_bar = 1 and clear_bar = 0 to initialize for say two clock cycle
        $display("\nDouble dabble algorithm testing");       
        for(reg[7:0] r= 8'b00000000; r <= 8'b11111110; r++)                 // exhaustive testing
            begin
                preset_bar=1;clear_bar=0;serial_in=0;mode=1;parallel_in=r;#20;
                preset_bar=1;clear_bar=1;mode=0;
                #90;
                $display("Input = %b        Output: D2 = %b, D1 = %b, D0 = %b", parallel_in, parallel_out_d2, parallel_out_d1,parallel_out_d0);
            end
            
        preset_bar=1;clear_bar=0;serial_in=0;mode=1;parallel_in=8'b11111111;#20;
        preset_bar=1;clear_bar=1;mode=0;
        #90;   
        $display("Input = %b        Output: D2 = %b, D1 = %b, D0 = %b", parallel_in, parallel_out_d2, parallel_out_d1,parallel_out_d0);

        // Exhaustive testing of all 8 bit numbers
        
        $display("\nEnd of test.");
        $finish;

    end

endmodule
