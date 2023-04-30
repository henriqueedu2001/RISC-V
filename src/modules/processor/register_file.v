/* register file */
module register_file #(
    parameter WORDSIZE = 64;            /* define o tamanho da palavra */
) (
    input clk,                          /* sinal de clock */
    input write_en,                     /* habilita escrita */
    input [4:0] write_addr,             /* endereço para escrita */
    input [WORDSIZE-1:0] write_data,    /* valor a ser escrito */
    input [4:0] addr_a,                 /* endereço do registrador A a ser lido */
    input [4:0] addr_b,                 /* endereço do registrador B a ser lido */
    output reg [WORDSIZE-1:0] data_a,   /* valor lido pelo registrador A */
    output reg [WORDSIZE-1:0] data_b    /* valor lido pelo registrador B */
);

    /* propriedades */

endmodule


