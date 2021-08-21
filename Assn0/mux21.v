`timescale 1ns/1ps

module mux21(x, y, s, z);
	input x, y;
	output z;
	wire w1, w2, sBar;

	not n1(sBar, s);
	and a1(w1, s, x);
	and a2(w2, sBar, y);
	or o1(z, w1, w2);
endmodule
