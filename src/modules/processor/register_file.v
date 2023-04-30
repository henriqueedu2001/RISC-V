/* register file */
module register_file #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter SIZE = 32                /* quantidade de registradores */
) (
    input wire clk,                          /* sinal de clock */
    input wire write_en,                     /* habilita escrita */
    input wire [4:0] write_addr,             /* endereço para escrita */
    input wire [WORDSIZE-1:0] write_data,    /* valor a ser escrito */
    input wire [4:0] addr_a,                 /* endereço do registrador A a ser lido */
    input wire [4:0] addr_b,                 /* endereço do registrador B a ser lido */
    output wire [WORDSIZE-1:0] data_a,       /* valor lido pelo registrador A */
    output wire [WORDSIZE-1:0] data_b        /* valor lido pelo registrador B */
);

    /* sinais de load para cada registrador */
    wire [SIZE-1:0] registers_load;

    /* saídas de 64 bits de cada registrador */           
    wire [SIZE-1:0] [WORDSIZE-1:0] registers_data_out;

    /* gera um banco de 32 registradores de 64 bits*/
    generate
        for (genvar i = 0; i < SIZE; i = i + 1) begin: REG_INST
            n_bits_register n_bits_reg (
                .clk(clk),
                .load(registers_load[i]),
                .reset(),
                .data_in(write_data),
                .data_out(registers_data_out[i])
            );
        end
    endgenerate

    assign registers_load[0] = write_en;
    assign data_a = registers_data_out[0];
    assign data_b = registers_data_out[0];

endmodule


