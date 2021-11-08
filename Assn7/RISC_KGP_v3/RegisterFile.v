/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`include "Register.v"
`ifndef _RF_
`define _RF_

module RegisterFile(
        input reg_write,
        input clk,
        input reset,
        input[4:0] read_register1,
        input[4:0] read_register2,
        input[4:0] write_register,
        input[31:0] write_data,
        output reg[31:0] read_data1,
        output reg[31:0] read_data2
    );

    reg[0:31] enableSignals;
    wire[31:0] data_bus[0:31];
    
	 always @(*) begin
			enableSignals = {32{1'b0}};
			if (reg_write) begin
					enableSignals[write_register] = 1'b1;
			end
			read_data1 = data_bus[read_register1];
         read_data2 = data_bus[read_register2];
	 end

    // Register registers[0:31] (write_data, enableSignals, clk, reset, data_bus);
    Register register0 (write_data, enableSignals[0], clk, reset, data_bus[0]);
    Register register1 (write_data, enableSignals[1], clk, reset, data_bus[1]);
    Register register2 (write_data, enableSignals[2], clk, reset, data_bus[2]);
    Register register3 (write_data, enableSignals[3], clk, reset, data_bus[3]);
    Register register4 (write_data, enableSignals[4], clk, reset, data_bus[4]);
    Register register5 (write_data, enableSignals[5], clk, reset, data_bus[5]);
    Register register6 (write_data, enableSignals[6], clk, reset, data_bus[6]);
    Register register7 (write_data, enableSignals[7], clk, reset, data_bus[7]);
    Register register8 (write_data, enableSignals[8], clk, reset, data_bus[8]);
    Register register9 (write_data, enableSignals[9], clk, reset, data_bus[9]);
    Register register10 (write_data, enableSignals[10], clk, reset, data_bus[10]);
    Register register11 (write_data, enableSignals[11], clk, reset, data_bus[11]);
    Register register12 (write_data, enableSignals[12], clk, reset, data_bus[12]);
    Register register13 (write_data, enableSignals[13], clk, reset, data_bus[13]);
    Register register14 (write_data, enableSignals[14], clk, reset, data_bus[14]);
    Register register15 (write_data, enableSignals[15], clk, reset, data_bus[15]);
    Register register16 (write_data, enableSignals[16], clk, reset, data_bus[16]);
    Register register17 (write_data, enableSignals[17], clk, reset, data_bus[17]);
    Register register18 (write_data, enableSignals[18], clk, reset, data_bus[18]);
    Register register19 (write_data, enableSignals[19], clk, reset, data_bus[19]);
    Register register20 (write_data, enableSignals[20], clk, reset, data_bus[20]);
    Register register21 (write_data, enableSignals[21], clk, reset, data_bus[21]);
    Register register22 (write_data, enableSignals[22], clk, reset, data_bus[22]);
    Register register23 (write_data, enableSignals[23], clk, reset, data_bus[23]);
    Register register24 (write_data, enableSignals[24], clk, reset, data_bus[24]);
    Register register25 (write_data, enableSignals[25], clk, reset, data_bus[25]);
    Register register26 (write_data, enableSignals[26], clk, reset, data_bus[26]);
    Register register27 (write_data, enableSignals[27], clk, reset, data_bus[27]);
    Register register28 (write_data, enableSignals[28], clk, reset, data_bus[28]);
    Register register29 (write_data, enableSignals[29], clk, reset, data_bus[29]);
    Register register30 (write_data, enableSignals[30], clk, reset, data_bus[30]);
    Register register31 (write_data, enableSignals[31], clk, reset, data_bus[31]);
    
endmodule 
`endif //_RF_