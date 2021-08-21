`timescale 1ns/1ns

module FA_Struct(a, b, cin, cout, sum);
 input  a, b, cin;      // inputs
 output cout, sum;      // output
 wire   w1, w2, w3, w4; // internal nets

 xor U1  (w1, a, b);
 xor U2  (sum, w1, cin);
 and U3  (w2, a, b);
 and U4  (w3, a, cin);
 and U5  (w4, b, cin);
 or  U6  (cout, w2, w3, w4);
endmodule

