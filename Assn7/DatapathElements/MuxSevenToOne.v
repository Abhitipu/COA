// make a 7 : 1 mux
module Mux7To1 (
        input[31:0] i_a,
        input[31:0] i_b,
        input[31:0] i_c,
        input[31:0] i_d,
        input[31:0] i_e,
        input[31:0] i_f,
        input[31:0] i_g,
        input[3:0] i_sel,
        output reg[31:0] o
    );

    always @(*) begin
        case (i_sel)
            0: o <= i_a;
            1: o <= i_b;
            2: o <= i_c;
            3: o <= i_d;
            4: o <= i_e;
            5: o <= i_f;
            6: o <= i_g;
        endcase
    end
endmodule