`timescale 1ns/1ns

module FA_Struct(a, b, cin, cout, sum);
 input  a, b, cin;      // inputs
 output cout, sum;      // output
 wire   w1, w2, w3, w4; // internal nets

 xor U1  (w1, a, b);
 xor U2  (sum, w1, cin);
 and U3  (w2, a, b);
 and U4  (w3, a, cin);
 and U5  (w4, b, cin);
 or  U6  (cout, w2, w3, w4);
endmodule


module dff_Struct(clk, D, Q,Q_BAR);
 input clk, D;
 output Q,Q_BAR;

 wire   clk, s0, s1, D, Q, Q_BAR; // internal nets
 
 nand U1 (s0,D,clk);   // U1: local name of the nand instance
 nand U2 (s1,s0,clk);  // U2: local name of the nand instance
 nand U3 (Q,Q_BAR,s0); // U3: local name of the nand instance
 nand U4 (Q_BAR,Q,s1); // U4: local name of the nand instance

endmodule

module multiplexer_struct(x , u , v , z);
	input x,u,v;
	output z;

	wire s0 , s1; // internal nets
	// xu + x_bar.v
	and U1(s0 , x , u);
	and U2(s1 , ~x , v);
	or U3(z , s0 , s1);
endmodule

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
/*
module shift_register(in , clk , q0 ,q1,q2,q3,mode);
	input [3:0] in;
	input mode;
	output q0 , q1 , q2 , q3;
	input clk;
	wire qb0 , qb1 , qb2 , qb3;
	reg d0 , d1 , d2 , d3;
	dff_Struct df0(clk,d0 ,q0,qb0);
	dff_Struct df1(clk,d1 ,q1,qb1);
	dff_Struct df2(clk,d2 ,q2,qb2);
	dff_Struct df3(clk,d3 ,q3,qb3);
	always @(posedge clk)
		if(clk)
			begin
				d0 = in[0];
				d1 = in[1];
				d2 = in[2];
				d3 = in[3];
			end
endmodule
*/
module nibble_converter(in , out);
	input[3:0] in;
	output [3:0] out;
	wire cout1;
	// x3 + x2(x0 + x1)
	wire w1 , w2 , w3;
	or U1(w1 , in[0] , in[1]);
	and U2(w2 , w1 , in[2]);
	or U3(w3 , w2 , in[3]);
	wire [3:0] temp;
	and U6(temp[3] , 0 , 0);
	and U7(temp[2] , 0 , 0);
	and U4(temp[1] , w3 , 1);
	and U5(temp[0] , w3 , 1);
	rca4 ra(in , temp, 1'b0 , out , cout1);

endmodule
module verilog_shift_register_test_PISO( din, clk, load, dout,in );

output reg dout;

input [3:0] din ;
input clk ;
input load ;
input in;

reg [3:0]temp;

always @ (posedge clk)
begin
   if (load)
      temp <= din;
   else
   begin
     dout <= temp[3];
     // 1101 0110 1010
     temp <= {temp[2:0],in};
   end
end
endmodule

module registerDisplay(in,out,clk,cout);
	input in;
	input clk;
	output reg[3:0] out;
	output cout;
	reg[3:0] temp;
	wire[3:0] temp_out;
	always @ (posedge clk)
	begin
		temp <= {temp[2:0],in};
		out<=temp;
//		nibble_converter nc(temp,temp_out);
		temp<=temp_out;
	end
endmodule

module top();

	reg [3:0] infornibble;
	wire [3:0] outfornibble;
	nibble_converter nib(infornibble , outfornibble);


	reg [3:0] in;
	wire out;
	reg clk;
	reg load;
	reg sft;
	verilog_shift_register_test_PISO shift(in , clk , load,out,sft);

	reg [3:0] A,B;
	reg cin1;
	wire [3:0] S;
	wire cout1;
	rca4 U3(A,B,cin1 , S , cout1);

	reg a , b ,cin; 
	wire cout,sum;
	FA_Struct FA(a,b,cin,cout,sum);

	reg  D;
	wire Q, Q_BAR;

	dff_Struct U1 (clk, D, Q,Q_BAR);

	reg x, u , v;
	wire z;
	multiplexer_struct U2(x,u,v,z);

	reg inp;
	wire[3:0] outp;
	wire carry;
	registerDisplay disp(inp,outp,clk,carry);

	initial

		begin
			$dumpfile("output.vcd");
			$dumpvars(0,top);
			$monitor($time , "a=%b,b=%b,cin=%b,cout=%b,sum=%b",a,b,cin,cout,sum);
			#0 a=1;b=1;cin=1;
			#2 a=1;b=0;cin=1;
			#2 a=0;b=1;cin=0;
			#1
		
			$monitor($time, "clk = %b D = %b Q = %b Q_BAR=%b" ,clk, D, Q,Q_BAR);
			clk = 0;
			D = 0;
			#3 D = 1;
			#3 D = 0;
			#1

			$monitor($time , "x=%b,u=%b,v=%b,z=%b",x,u,v,z);
			#0 x=1;u=1;v=0;
			#2 x=0;u=0;v=1;
			#2 x=1;u=0;v=1;
			#1

			$monitor($time , "A=%b,B=%b,cin1=%b,cout1=%b,S=%b",A,B,cin1,cout1,S);
			#0 A=4'b1001;B=4'b0110;cin1=0;
			#6 A=4'b1101;B=4'b0110;cin1=0;
			#1

			$monitor($time , "in=%b,out=%b",in,out);
			load=1'b1;sft=1'b0;
			#0 in=4'b1101;
			#3 load=1'b0;
			#3 in=4'b1101;
			#3 in=4'b1101;
			#3 in=4'b1101;
			#2
//			#3 load=1'b1;in=4'b1001;
//			#3 load=1'b0;
			#2


			$monitor($time , "in_nibble=%b,out_nibble=%b",infornibble,outfornibble);
			#0 infornibble=4'b0101;
			#6 infornibble=4'b0100;

			
			$monitor($time , "in=%b,out=%b,cout=%b",inp,outp,carry);
			#0 inp=1'b1;

			#1
			#3 $finish;


		end
		always #2 clk = ~clk;
//		always #2 clk1 = ~clk1;

endmodule
