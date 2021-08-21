
module halfAdder (a, b, cout, sum);
input a,b;              // inputs
output sum,cout;        // outputs
    and U1(sum,a,b);    
    xor U2(cout,a,b);
endmodule