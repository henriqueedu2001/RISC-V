/* data memory */
module data_memory #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input clk,                          /* sinal de clock */
    input [WORDSIZE-1:0] addr,          /* endereço para leitura ou escrita */
    input [WORDSIZE-1:0] data_input,    /* valor de escrita */
    input write_en,                     /* habilita escrita */
    output [WORDSIZE-1:0] data_output   /* valor lido */
);

    /* propriedades */

endmodule