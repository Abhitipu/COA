/*
Assignment 5
Problem no: 1
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`timescale 1ns/1ns // <time unit> / <time precision>

`ifndef _MUX_v_
`define _MUX_v_

module multiplexer_struct(x , u , v , z);
	input x,u,v;
	output z;
	
	// z = xu + x_bar.v
	assign z = x ? u: v;
endmodule

`endif // _MUX_v_