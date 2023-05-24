/* instruction_memory */
module instruction_memory #(
    parameter WORDSIZE = 64,           /* tamanho da palavra (64) */
    parameter INSTRUCTION_SIZE = 32,   /* tamanho da instrução (32 para o RISC-V) */
    parameter MEMORY_SIZE = 1024       /* tamanho da memória (1024) */
) (
    input wire [WORDSIZE-1:0] addr,                  /* endereço da instrução */
    output wire [INSTRUCTION_SIZE-1:0] instruction   /* instrução correspondente */
);
    /* algumas instruções de início */
    localparam 
        /* load word */
        instruction_01 = {
            12'b0000_0110_1011,  /* immediate */
            5'b00111,            /* rs1 */
            3'b000,              /* funct3 */
            5'b00011,            /* rd */
            7'b0000011           /* opcode */
        },
        /* store word */
        instruction_02 = {
            7'b1011011,          /* immediate[11:5] */
            5'b00111,            /* rs2 */
            5'b10011,            /* rs1 */
            3'b000,              /* funct3 */
            5'b00011,            /* immediate[4:0] */
            7'b0100011           /* opcode */
        },
        /* add */
        instruction_03 = {
            7'b0000000,          /* funct7 */
            5'b00111,            /* rs2 */
            5'b10011,            /* rs1 */
            3'b000,              /* funct3 */
            5'b00011,            /* rd */
            7'b0110011           /* opcode */
        },
        /* sub */
        instruction_04 = {
            7'b0100000,          /* funct7 */
            5'b11111,            /* rs2 */
            5'b11001,            /* rs1 */
            3'b000,              /* funct3 */
            5'b00110,            /* rd */
            7'b0110011           /* opcode */
        };

    reg [MEMORY_SIZE-1:0] instructions [INSTRUCTION_SIZE-1:0] ; /* banco de instruções */
    reg [INSTRUCTION_SIZE-1:0] selected_instruction;           /* instrução selecionada */

    /* conjunto de instruções iniciais */
    initial begin
        $readmemb("./instruction_memory_archive.txt", instructions, 0, 3);
    end

    /* selecionar instrução do endereço correto */
    always @(*) begin
        selected_instruction = instructions[addr];
    end

    /* instrução de saída */
    assign instruction = selected_instruction;

endmodule

// $readmemb("instruction_memory_archive.txt", instructions, 0, 3);