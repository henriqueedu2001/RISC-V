/* instruction_memory */
module instruction_memory #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32,
    parameter SIZE = 1024               /* tamanho da memória */
) (
    input wire [WORDSIZE-1:0] addr
    output wire [INSTRUCTION_SIZE-1:0] instruction
);
    reg [SIZE-1:0] [INSTRUCTION_SIZE-1:0] instructions;
    
    /* propriedades */

endmodule