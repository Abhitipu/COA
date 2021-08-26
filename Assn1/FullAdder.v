`timescale 1ns/1ns

`ifndef _FA_v_
`define _FA_v_
module FA_Struct(a, b, cin, cout, sum);
 input  a, b, cin;      // inputs
 output cout, sum;      // output
 wire   w1, w2, w3; // internal nets

 xor U1  (w1, a, b);
 xor U2  (sum, w1, cin);
 and U3  (w2, cin, w1);
 and U4  (w3, a, b);
 or  U6  (cout, w2, w3);
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
