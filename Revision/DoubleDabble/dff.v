`timescale 1ns/1ns
`ifndef _dff_v_
`define _dff_v_

module d_flip_flop_edge_triggered(D, CLK, Q, Qn, Preset_Bar, Clear_Bar);
    output Q,Qn;
    input  CLK,Clear_Bar,Preset_Bar,D;


    wire   CLKn;   // Negated Clock
    wire   Dn;  // Input Negated D
    wire s1,s2,s3,s4,s5,s6; //Internal net
    not(CLKn, CLK);
    not(Dn, D);

    //master
    // level 1 circuit
    nand(s1, D, CLK);
    nand(s2, Dn, CLK);
    
    //level 2 circuit
    nand(s3, s1, s4, Preset_Bar);
    nand(s4, s2, s3, Clear_Bar);

    //slave
    //level 1 circuit
    nand(s5, s3, CLKn);
    nand(s6, s4, CLKn);

    //level 2 circuit
    nand(Q, s5, Qn);
    nand(Qn, s6, Q);

endmodule // d_flip_flop_edge_triggered negative

`endif //_dff_v_
