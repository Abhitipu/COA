`timescale 1ns/1ns // <time unit> / <time precision>

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
