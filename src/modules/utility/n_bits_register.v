/* banco de registradores */
module n_bits_register #(
    parameter WORDSIZE = 64              /* define tamanho da palavra */
) (
    input wire clk,                      /* sinal de clock */
    input wire load,                     /* sinal de load */ 
    input wire reset,                    /* sinal de reset */
    input wire [WORDSIZE-1:0] data_in,   /* palavra a ser escrita */
    output wire [WORDSIZE-1:0] data_out  /* palavra a ser lida */
);
    /* instanciação de N = WORDSIZE registradores */
    genvar i;
    generate
        for(i = 0; i < WORDSIZE; i = i + 1) begin     
            one_bit_register sg(
                .clk(clk),
                .load(load),
                .reset(reset),
                .data_in(data_in[i]),
                .data_out(data_out[i])
            );
        end
    endgenerate
endmodule