/* multiplexador 4x1 */
module mux_4x1 (
    input wire [3:0] in,   /* inputs */
    input wire [1:0] sel,  /* seletor */
    output wire out        /* output */
);
    /* 0 -> sel = in[0]; 1 -> sel = in[1] */
    assign out = (~sel[0] & ~sel[1] & in[0]) | 
                 (~sel[0] &  sel[1] & in[1]) | 
                 ( sel[0] & ~sel[1] & in[2]) | 
                 ( sel[0] &  sel[1] & in[3]);
endmodule