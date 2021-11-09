/*
Assignment 7
Problem no:5 
Semester: 5th
Group: 28
Members: 
Aryan Singh (19CS30007)
Abhinandan De (19CS10069)
*/
`timescale 1ns / 1ps

module datamemory(
    input clka,
    input ena,
    input [3 : 0] wea,
    input [31 : 0] addra,
    input [31 : 0] dina,
    output [31 : 0] douta
  );

 myBram myb(
  clka,
  ena,
  wea,
  addra,
  dina,
  douta
);

endmodule
