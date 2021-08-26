
`ifndef _HA_v_
`define _HA_v_
module halfAdder (a, b, sum, cout);
input a,b;              // inputs
output sum,cout;        // outputs
 assign cout = a&b;   
 assign sum = a^b;
endmodule

`endif // _HA_v_
// Truth Table
//      a   b   sum cout
//      0   0   0   0
//      0   1   1   0
//      1   0   1   0
//      1   1   0   1