/*
Assignment 6
Problem no: 2
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/

module shift_register(
    input[7:0] parallelIn,
    input serialIn,
    input mode,
    input dir,
    input reset,
    input clk,
    output reg serialOut,
    output reg[7:0] state
);
    always @(posedge clk or posedge reset) begin
        if(reset)
            state <= 8'b00000000;
        else if(mode)
            state <= parallelIn;
        else if(dir)
            state <= {state[6:0], serialIn};
        else
            state <= {serialIn, state[7:1]};
        if (dir)
            serialOut <= state[7];
        else
            serialOut <= state[0];
    end
endmodule