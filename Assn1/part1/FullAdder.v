`timescale 1ns/1ns

`ifndef _FA_v_
`define _FA_v_
module FA_Struct(a, b, cin, cout, sum);
 input  a, b, cin;      // inputs
 output cout, sum;      // output
 assign sum = a^b^cin;
 assign cout = (a&b) | ((a^b)&cin);
endmodule
`endif  // _FA_v_
// Truth Table
//      a   b   cin sum cout
//      0   0   0   0   0
//      0   0   1   1   0
//      0   1   0   1   0
//      0   1   1   0   1
//      1   0   0   1   0
//      1   0   1   0   1
//      1   1   0   0   1
//      1   1   1   1   1
