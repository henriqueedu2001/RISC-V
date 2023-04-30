/* unidade lógico aritmética */
module alu #(
    parameter WORDSIZE = 64;            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [2:0] operation,         /* operação a ser realizada */
    output wire [WORDSIZE-1:0] result   /* resultado */
    output wire overflow                /* sinal de detecção de overflow */
);

    /* propriedades */
    
endmodule