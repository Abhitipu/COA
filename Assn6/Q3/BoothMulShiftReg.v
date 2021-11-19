/*
Assignment 6
Problem no: 3
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)

A shift register capable of handling the following operations
needed for BoothsMultiplication
- Reset
- Parallel Load to lower 8 bits
- Modified Shifting based on Q0Q-1
- Parallel Read
Booth's Multiplication Shift Register - bmsr
*/
`include "AdderSub.v"
module bmsr(
    input[7:0] parallelIn,
    input[7:0] Multiplicand,
    input mode,
    input reset,
    input clk,
    output reg[15:0] parallelOut
);
    wire [7:0] OperatedM;
    wire Qxor;
    reg Qminus1;
    assign Qxor = parallelOut ^ Qminus1;
    rcas8 rcas_1(.A(parallelOut[15:8]), .B(Multiplicand), .mode(parallelOut[0]), .S(OperatedM) );
    always @(posedge clk or posedge reset) begin
        if(reset)
            begin
                parallelOut <= 16'b0000000000000000;
                Qminus1 <= 1'b0;
            end
        else if(mode)
            begin
                parallelOut <= {8'b00000000, parallelIn};
                Qminus1 <= 1'b0;
            end 
        else
            begin
                if(Qxor)
                    parallelOut <= {OperatedM[7], OperatedM[7:0], parallelOut[7:1]};
                else
                    parallelOut <= {parallelOut[15], parallelOut[15:1]};
                Qminus1 <= parallelOut[0];
            end
    end
endmodule
/*
    Module Logic
    Whenever Q0 xor Q-1 = 1, we either do A+=M or A-=M
        or in other words we operate on A with M (we say this as operatedM), 
        and when Q0 = 1, Q-1 = 0 we use A-=M
        and when Q0 = 0, Q-1 = 1 we use A+=M
    In every cycle we use modified Arthimetic shift 
        that if Q0 xor Q-1 == 1 we use operatedM as upper 8 bits
        else we use previously stored value on ParallelOut
    
    CAUTION: Using -128 or 8'b 1111 1111 as Multiplicand may lead to erroneous value Since 2's complement of -128 is also -128 (overflow).
             Thus the sign bit of (-(-128)) remains to be 1 instead of 0, hence arthimetic shift can induce error at this point.
    POSSIBLE SOLUTION: This can be handled by using an adder with more than 8bit so that -(-128) can be represented correctly.
                       But this breaks the standard design convention of using 8 bit register.
    
*/