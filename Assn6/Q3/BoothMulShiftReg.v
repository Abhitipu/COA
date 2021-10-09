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
- Booth's Multiplication Shift Register - bmsr
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
