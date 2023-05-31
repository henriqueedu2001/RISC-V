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

    /* gera um banco de 32 registradores de 64 bits */
    genvar i;
    generate
        for (i = 0; i < SIZE; i = i + 1) begin: REG_INST
            n_bits_register n_bits_reg (
                .clk(clk),
                .load(registers_load[i]),
                .reset(),
                .data_in(write_data),
                .data_out(registers_data_out[i])
            );
        end
    endgenerate

    /* coloca o sinal de load nos registradores corretos */
    generate
        for (i = 0; i < SIZE; i = i + 1) begin
            assign registers_load[i] = (write_en) & (write_addr == i);
        end
    endgenerate

    /* leitura dos registradores A e B */
    reg [WORDSIZE-1:0] a; /* valor de saída do registrador a */
    reg [WORDSIZE-1:0] b; /* valor de saída do registrador b */

    /* TODO tornar remover o always e usar apenas assign */

    /* ativação em qualquer instante */
    always @ (*) begin
        /* leitura assíncrona com o clock */
        a <= registers_data_out[addr_a]; 
        b <= registers_data_out[addr_b];
    end

    /* valores lidos em A e em B */
    assign data_a = 64'd3;
    assign data_b = 64'd2;

endmodule


