/* unidade de controle */
module control_unit #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) (
    input wire clk,                                /* sinal de clock */
    input wire [INSTRUCTION_SIZE-1:0] instruction, /* instrução do risc-v */
    output reg [4:0] cu_rf_addr_a,                 /* seleção de addr_a no register file */
    output reg [4:0] cu_rf_addr_b,                 /* seleção de addr_b no register file */
    output reg [4:0] cu_rf_write_addr,             /* seleção de write_addr no register file */
    output reg cu_rf_write_en,                     /* habilita escrita no register file */
    output reg [WORDSIZE-1:0] cu_immediate,        /* immediate da instrução */
    output reg cu_mux_0_sel,                       /* seleção do primeiro mux (entrada para alu) */
    output reg cu_mux_1_sel,                       /* seleção do segundo mux (entrada para alu) */
    output reg cu_mux_2_sel,                       /* seleção do terceiro mux (entrada para register file) */
    output reg [2:0] cu_alu_operation,             /* definição da operação da alu */
    output reg cu_dm_write_en                      /* habilita escrita no data_memory */

);
    /* alguns possíveis opcodes */
    localparam 
        op_code_load_word = 7'b0000011,
        op_code_store_word = 7'b0100011,
        op_code_add = 7'b0110011,
        op_code_sub = 7'b0110011,
        op_code_addi = 7'b0010011,
        op_code_subi = 7'b0010011;
    
    /* alguns possíveis funct7 */
    localparam 
        funct7_add = 7'b0000000,
        funct7_sub = 7'b0100000;

    /* obtenção do op_code da instrução */
    wire [6:0] op_code;
    assign op_code = instruction[6:0];

    /* instruções tipo I */
    wire [11:0] i_type_imm;
    wire [4:0] i_type_rs1;
    wire [2:0] i_type_funct3;
    wire [4:0] i_type_rd;
    wire [6:0] i_type_opcode;

    /* instruções tipo S */
    wire [6:0] s_type_imm1;
    wire [4:0] s_type_rs2;
    wire [4:0] s_type_rs1;
    wire [2:0] s_type_funct3;
    wire [4:0] s_type_imm2;
    wire [6:0] s_type_opcode;

    /* instruções tipo S */
    wire [6:0] funct7;
    wire [4:0] rs2;
    wire [4:0] rs1;
    wire [2:0] funct3;
    wire [4:0] rd;
    wire [6:0] opcode;

    /* sinais separados por tipos */
    always @(*) begin
        case (op_code)
            /* instrução load word: lw rd, #immediate(rs1) */
            op_code_load_word: begin
                cu_rf_addr_a = 0;       /* recebe rs1 */
                cu_rf_addr_b = 0;       /* irrelevante */
                cu_rf_write_addr = 0;   /* rd */
                cu_rf_write_en = 1;     /* ativa escrita no register file */
                cu_immediate = 0;       /* recebe immediate */
                cu_mux_0_sel = 0;       /* seleciona o rs1 */
                cu_mux_1_sel = 0;       /* seleciona o immediate */
                cu_mux_2_sel = 0;       /* seleciona o resultado da ALU  */
                cu_alu_operation = 0;   /* recebe operação de soma */
                cu_dm_write_en = 0;     /* desativa escrita no data memory */
            end
            op_code_load_word: begin
            end
            op_code_load_word: begin
            end
            op_code_load_word: begin
            end
            default: begin
            end
        endcase
    end

endmodule