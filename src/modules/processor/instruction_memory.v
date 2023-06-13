/* instruction_memory */
module instruction_memory #(
    parameter WORDSIZE = 64,           /* tamanho da palavra (64) */
    parameter INSTRUCTION_SIZE = 32,   /* tamanho da instrução (32 para o RISC-V) */
    parameter MEMORY_SIZE = 1024       /* tamanho da memória (1024) */
) (
    input wire [WORDSIZE-1:0] addr,                  /* endereço da instrução */
    output wire [INSTRUCTION_SIZE-1:0] instruction   /* instrução correspondente */
);

    reg [MEMORY_SIZE-1:0] instructions [INSTRUCTION_SIZE-1:0] ; /* banco de instruções */
    reg [INSTRUCTION_SIZE-1:0] selected_instruction;           /* instrução selecionada */

    /* conjunto de instruções iniciais */
    initial begin
        // Load A e Load B
        instructions[0] = 32'b0000000_00000_00000_010_00001_0000011;
        instructions[1] = 32'b0000100_00000_00000_010_00010_0000011;

        // Add e sub
        instructions[2] = 32'b0100000_00010_00001_000_00011_0110011;
        // instructions[3] = 32'b0000000_00010_00001_000_00011_0110011;

        // BEQ
        instructions[3] = 32'b0000000_00010_00001_000_00110_1100011;
        
    end

    /* selecionar instrução do endereço correto */
    always @(*) begin
        selected_instruction = instructions[addr];
    end

    /* instrução de saída */
    assign instruction = selected_instruction;

endmodule
