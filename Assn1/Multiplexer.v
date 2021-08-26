`timescale 1ns/1ns // <time unit> / <time precision>

`ifndef _MUX_v_
`define _MUX_v_
module multiplexer_struct(x , u , v , z);
	input x,u,v;
	output z;
	// xu + x_bar.v
	assign z = x ? u: v;
endmodule
`endif // _MUX_v_