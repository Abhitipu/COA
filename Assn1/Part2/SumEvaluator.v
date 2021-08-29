`timescale 1ns/1ns
`ifndef _SE_v_
`define _SE_v_

module SE(p, cin, sum);

    input[3:0]  p, cin;
    output[3:0] sum;

    assign sum = p^cin;

endmodule

`endif  // _SE_v_