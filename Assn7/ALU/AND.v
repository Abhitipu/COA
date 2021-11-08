/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

`ifndef _AND_v_
`define _AND_v_

module AND(
            input[31:0] A, 
            input[31:0] B,
            output[31:0] And_out
            );
    and u[31:0] (And_out, A, B);
endmodule //_AND_v_
`endif // AND_v