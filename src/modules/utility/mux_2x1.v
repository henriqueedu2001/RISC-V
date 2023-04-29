/* multiplexador 2x1 */
module mux_2x1 (
    input wire [1:0] in,  /* inputs */
    input wire sel,       /* seletor */
    output wire out       /* output */
);
    /* seletor: 
        0: out = in[0]; 
        1: out = in[1] 
    */
    assign out = (~sel & in[0]) | (sel & in[1]);
endmodule