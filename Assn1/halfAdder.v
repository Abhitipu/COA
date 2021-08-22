
module halfAdder (a, b, sum, cout);
input a,b;              // inputs
output sum,cout;        // outputs
    and U1(cout,a,b);    
    xor U2(sum,a,b);
endmodule

// Truth Table
//      a   b   sum cout
//      0   0   0   0
//      0   1   1   0
//      1   0   1   0
//      1   1   1   1