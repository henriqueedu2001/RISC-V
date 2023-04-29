/* registrador unitário */
module single_register #(parameter N = 64) (
    input wire clk,        /* sinal de clock */
    input wire load,       /* sinal de load */
    input wire reset,      /* sinal de reset */
    input wire data_in,    /* dado para escrita */
    output wire data_out   /* dado de leitura */
);
    /* latch que armazena o valor */
    reg data;
    
    /* iniciar registrador zerado */
    initial begin
        data = 0;
    end

    /* ativação em borda de subida do clock */
    always @(posedge clk) begin
        /* escrever data_in se load = 1 */
        if(load)
            data = data_in;
        
        /* zerar registrador se reset = 1 */
        if(reset)
            data = 0;
    end

    /* data_out recebe valor de saída do latch */
    assign data_out = data;

endmodule