/* data memory */
module data_memory #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter SIZE = 512               /* tamanho da memória */
) (
    input clk,                          /* sinal de clock */
    input [WORDSIZE-1:0] addr,          /* endereço para leitura ou escrita */
    input [WORDSIZE-1:0] data_input,    /* valor de escrita */
    input write_en,                     /* habilita escrita */
    output [WORDSIZE-1:0] data_output   /* valor lido */
);

    /* banco de  */
    reg [WORDSIZE:0] memory [SIZE-1:0];
    
    initial begin
        memory[0] = 64'd5;
        memory[1] = 64'd5;
    end
    /* ativação em borda de subida */
    always @(posedge clk) begin
        /* escrita de dados na memória */
        if (write_en) 
            memory[addr] <= data_input;
    end

    /* saída de leitura */
    assign data_output = memory[addr];
    
endmodule