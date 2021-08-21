`timescale 1ns/1ns
`include "dff.v"
`include "nibbleconverter.v"


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

d_flip_flop_edge_triggered dff0(.D(serial_in), .CLK(clk), .Q(parallel_out[0]), .Qn(), .Preset_Bar(preset_bar), .Clear_Bar(clear_bar));
d_flip_flop_edge_triggered dff1(.D(ns[0]), .CLK(clk), .Q(parallel_out[1]), .Qn(), .Preset_Bar(preset_bar), .Clear_Bar(clear_bar));
d_flip_flop_edge_triggered dff2(.D(ns[1]), .CLK(clk), .Q(parallel_out[2]), .Qn(), .Preset_Bar(preset_bar), .Clear_Bar(clear_bar));
d_flip_flop_edge_triggered dff3(.D(ns[2]), .CLK(clk), .Q(parallel_out[3]), .Qn(), .Preset_Bar(preset_bar), .Clear_Bar(clear_bar));

nibble_converter nb(parallel_out,ns);
assign carry = ns[3];



    
endmodule
