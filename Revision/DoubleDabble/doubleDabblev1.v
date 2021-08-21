/*****Instructions*****/
/*

To compile : 
iverilog -o doubleDabble doubleDabble.v

To run:
vvp doubleDabble

To analyse plots:
gtkwave doubleDabble_tb.vcd

The program will do exhaustive testing of all 8 bit numbers
It will display the input followed by the binary representation of the three output bits.
After successful completion it will print "End of test."

To analyse waveforms use 
gtkwave doubleDabble_tb.vcd

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


// Nibble Converter (add 4)

module nibble_converter(in , out);
	input[3:0] in;
	output [3:0] out;

	wire cout1;
	// w3=x3 + x2(x0 + x1)
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

    // 8 cascaded units

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

module top();

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
        $dumpvars(0,top); 

        // Note : first apply preset_bar = 1 and clear_bar = 0 to initialize for say two clock cycle
        
        for(reg[7:0] r= 8'b00000000; r <= 8'b11111110; r++)
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
        
        $display("end of test.");
        $finish;

    end

endmodule
