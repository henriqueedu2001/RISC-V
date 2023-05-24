/* unidade de controle */
module control_unit #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) (
    input wire [6:0] opcode,                       /* opcode */
    output reg [] alu_op,
    output reg [4:0] uc_rf_addr_a,                 /* seleção de addr_a no register file */
    output reg [4:0] uc_rf_addr_b,                 /* seleção de addr_b no register file */
    output reg [4:0] uc_rf_write_addr,             /* seleção de write_addr no register file */
    output reg uc_rf_write_en,                     /* habilita escrita no register file */
    output reg [WORDSIZE-1:0] uc_immediate,        /* immediate da instrução */
    output reg uc_mux_0_sel,                       /* seleção do primeiro mux (entrada para alu) */
    output reg uc_mux_1_sel,                       /* seleção do segundo mux (entrada para alu) */
    output reg uc_mux_2_sel,                       /* seleção do terceiro mux (entrada para register file) */
    output reg [2:0] uc_alu_operation,             /* definição da operação da alu */
    output reg uc_dm_write_en                      /* habilita escrita no data_memory */

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

    assign i_type_imm = instruction[31:20];
    assign i_type_rs1 = instruction[19:15];
    assign i_type_funct3 = instruction[14:12];
    assign i_type_rd = instruction[11:7];
    assign i_type_opcode = instruction[6:0];

    /* instruções tipo S */
    wire [6:0] s_type_imm1;
    wire [4:0] s_type_rs2;
    wire [4:0] s_type_rs1;
    wire [2:0] s_type_funct3;
    wire [4:0] s_type_imm2;
    wire [6:0] s_type_opcode;
    wire [11:0] s_type_imm;

    assign s_type_imm1 = instruction[31:25];
    assign s_type_rs2 = instruction[24:20];
    assign s_type_rs1 = instruction[19:15];
    assign s_type_funct3 = instruction[14:12];
    assign s_type_imm2 = instruction[11:7];
    assign s_type_opcode = instruction[6:0];
    assign s_type_imm = {s_type_imm1, s_type_imm2};

    /* instruções tipo R */
    wire [6:0] r_type_funct7;
    wire [4:0] r_type_rs2;
    wire [4:0] r_type_rs1;
    wire [2:0] r_type_funct3;
    wire [4:0] r_type_rd;
    wire [6:0] r_type_opcode;

    assign r_type_funct7 = instruction[31:0];
    assign r_type_rs2 = instruction[24:20];
    assign r_type_rs1 = instruction[19:15];
    assign r_type_funct3 = instruction[14:12];
    assign r_type_rd = instruction[11:7];
    assign r_type_opcode = instruction[6:0];

    /* sinais separados por tipos */
    always @(*) begin
        case (op_code)
            /* instrução load word: lw rd, #immediate(rs1) */
            op_code_load_word: begin
                uc_rf_addr_a = i_type_rs1;       /* recebe rs1 */
                uc_rf_addr_b = i_type_rd;        /* irrelevante */
                uc_rf_write_addr = i_type_rd;    /* rd */
                uc_rf_write_en = 1;              /* ativa escrita no register file */
                uc_immediate = i_type_imm;       /* recebe immediate */
                uc_mux_0_sel = 0;                /* seleciona o rs1 */
                uc_mux_1_sel = 0;                /* seleciona o immediate */
                uc_mux_2_sel = 0;                /* seleciona o resultado da ALU  */
                uc_alu_operation = 3'b000;       /* recebe operação de soma */
                uc_dm_write_en = 0;              /* desativa escrita no data memory */
            end

            /* instrução de store word: sw rs1, #imm(rs2) */
            op_code_store_word: begin
                uc_rf_addr_a = s_type_rs1;       /* recebe rs1 */
                uc_rf_addr_b = s_type_rs2;       /* recebe rs2 */
                uc_rf_write_addr = 0;            /* irrelevante */
                uc_rf_write_en = 0;              /* ativa escrita no register file */
                uc_immediate = s_type_imm;       /* recebe immediate */
                uc_mux_0_sel = 1;                /* seleciona o rs1 */
                uc_mux_1_sel = 0;                /* seleciona o immediate */
                uc_mux_2_sel = 0;                /* seleciona o resultado da ALU  */
                uc_alu_operation = 3'b000;       /* recebe operação de soma */
                uc_dm_write_en = 1;              /* desativa escrita no data memory */
            end

            /* instrução add: add rd, rs1, rs2 */
            op_code_add: begin
                uc_rf_addr_a = r_type_rs1;       /* recebe rs1 */
                uc_rf_addr_b = r_type_rs2;       /* recebe rs2 */
                uc_rf_write_addr = r_type_rd;    /* recebe rd */
                uc_rf_write_en = 1;              /* ativa escrita no register file */
                uc_immediate = 0;                /* irrelevante */
                uc_mux_0_sel = 0;                /* seleciona o rs1 */
                uc_mux_1_sel = 1;                /* seleciona o rs2 */
                uc_mux_2_sel = 0;                /* seleciona o resultado da ALU */
                uc_alu_operation = 3'b000;       /* recebe operação de soma */
                uc_dm_write_en = 0;              /* desativa escrita no data memory */
            end

            /* instrução sub */
            op_code_sub: begin
                uc_rf_addr_a = r_type_rs1;       /* recebe rs1 */
                uc_rf_addr_b = r_type_rs2;       /* recebe rs2 */
                uc_rf_write_addr = r_type_rd;    /* recebe rd */
                uc_rf_write_en = 1;              /* ativa escrita no register file */
                uc_immediate = 0;                /* irrelevante */
                uc_mux_0_sel = 0;                /* seleciona o rs1 */
                uc_mux_1_sel = 1;                /* seleciona o rs2 */
                uc_mux_2_sel = 0;                /* seleciona o resultado da ALU */
                uc_alu_operation = 3'b000;       /* recebe operação de soma */
                uc_dm_write_en = 0;              /* desativa escrita no data memory */
            end
            default: begin
            end
        endcase
    end

endmodule