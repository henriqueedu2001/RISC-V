/* descrição */
module imm_gen #(
    parameter WORDSIZE = 64,            /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32     /* tamanho da instrução (32 para o RISC-V) */
) (
    input wire [INSTRUCTION_SIZE-1:0] instruction,  /* instrução em 32 bits */
    input wire [WORDSIZE-1:0] immediate             /* immediate em 64 bits */
);

    /* propriedades */
    reg [WORDSIZE-1:0] imm;

    always @(*) begin
        case (instruction)
            
        endcase
    end

endmodule