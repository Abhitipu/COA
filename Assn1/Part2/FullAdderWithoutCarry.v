`timescale 1ns/1ns
`ifndef _FA_v_
`define _FA_v_

module FA_Struct(p, cin, sum);

    input[3:0]  p, cin;
    output[3:0] sum;

    assign sum = p^cin;

endmodule

`endif  // _FA_v_