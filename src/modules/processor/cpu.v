/* descrição */
module cpu #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter SIZE = 512,              /* tamanho da memória */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) (
    input wire clk,                                 /* sinal de clock para demais componentes da cpu*/
   );
    


endmodule