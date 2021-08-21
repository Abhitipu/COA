`timescale 1ns/1ns
`include "RippleCarryAdder.v"

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
