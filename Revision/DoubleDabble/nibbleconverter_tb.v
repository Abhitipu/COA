`timescale 1ns/1ns
`include "nibbleconverter.v"



module nibbleconverter_tb;
reg [3:0] in;
wire [3:0] z;
nibble_converter nc(in,z);

initial begin
    $dumpfile("nibbleconverter_tb.vcd");
    $dumpvars(0,nibbleconverter_tb);

    in = 4'b0100;#20;
    in = 4'b0101;#20;
    in = 4'b0110;#20;
    in = 4'b0000;#20;
    $display("end of test.");
end

endmodule
