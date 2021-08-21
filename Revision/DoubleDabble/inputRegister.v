`timescale 1ns/1ns
`include "dff.v"
`include "Multiplexer.v"


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

module InputRegister (
    parallel_in,// parallel input of size 8 bit
    serial_in,//serial_in
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
    InputRegister_unit u0(
    parallel_in[0],
    serial_in,
    mode,
    preset_bar,
    clear_bar,
    clk,
    s[0]
    );
    InputRegister_unit u1(
    parallel_in[1],
    s[0],
    mode,
    preset_bar,
    clear_bar,
    clk,
    s[1]
    );
    InputRegister_unit u2(
    parallel_in[2],
    s[1],
    mode,
    preset_bar,
    clear_bar,
    clk,
    s[2]
    );
    InputRegister_unit u3(
    parallel_in[3],
    s[2],
    mode,
    preset_bar,
    clear_bar,
    clk,
    s[3]
    );
    InputRegister_unit u4(
    parallel_in[4],
    s[3],
    mode,
    preset_bar,
    clear_bar,
    clk,
    s[4]
    );
    InputRegister_unit u5(
    parallel_in[5],
    s[4],
    mode,
    preset_bar,
    clear_bar,
    clk,
    s[5]
    );
    InputRegister_unit u6(
    parallel_in[6],
    s[5],
    mode,
    preset_bar,
    clear_bar,
    clk,
    s[6]
    );
    InputRegister_unit u7(
    parallel_in[7],
    s[6],
    mode,
    preset_bar,
    clear_bar,
    clk,
    serial_out
    );



endmodule
