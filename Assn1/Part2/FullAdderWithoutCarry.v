`timescale 1ns/1ns
`ifndef _FA_v_
`define _FA_v_

module FA_Struct(a, b, cin, sum);

    input  a, b, cin;
    output sum;

    assign sum = a&b | (a^b)&cin;

endmodule

`endif  // _FA_v_