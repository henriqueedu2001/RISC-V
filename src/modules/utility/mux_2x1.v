/* descrição */
module mux_2x1 #(
    parameter N = 64
) (
    input wire [1:0] in,  /* inputs */
    input wire sel,       /* seletor */
    output wire out       /* output */
);
    /* 0 -> sel = in[0]; 1 -> sel = in[1] */
    assign out = (~sel & in[0]) | (sel & in[1]);
endmodule