/*
Assignment 6
Problem no: 1
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`ifndef _MUX_v_
`define _MUX_v_
module Multiplexer(
		input x,
		input u,
		input v,
		output z
	 );
		// z = xu + x'v
		assign z = x ? u : v;

endmodule
`endif //_MUX_v_