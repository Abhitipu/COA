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
// A shift register with sync parallel/serial load, async reset, bi directional shifting and parallel/serial read
    always @(posedge clk or posedge reset) begin
        if(reset)                                   // reset
            state <= 8'b00000000;
        else if(mode)                               // mode == 1, load
            state <= parallelIn;
        else if(dir)                                // dir == 1, left shift
            state <= {state[6:0], serialIn};
        else                                        // dir == 0, right shift
            state <= {serialIn, state[7:1]};
        if (dir)                                    // dir == 1, serial out is left most bit
            serialOut <= state[7];
        else
            serialOut <= state[0];                  // dir == 0, serial out is right most bit
    end
endmodule