`timescale 1ps/1ps

/* teste do módulo [...] */
module control_unit_test #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) ();

    reg clk;                                /* sinal de clock */
    reg [INSTRUCTION_SIZE-1:0] instruction; /* instrução do risc-v */
    wire [4:0] cu_rf_addr_a;                /* seleção de addr_a no register file */
    wire [4:0] cu_rf_addr_b;                /* seleção de addr_b no register file */
    wire [4:0] cu_rf_write_addr;            /* seleção de write_addr no register file */
    wire cu_rf_write_en;                    /* habilita escrita no register file */
    wire [WORDSIZE-1:0] cu_immediate;       /* immediate da instrução */
    wire cu_mux_0_sel;                      /* seleção do primeiro mux (entrada para alu) */
    wire cu_mux_1_sel;                      /* seleção do segundo mux (entrada para alu) */
    wire cu_mux_2_sel;                      /* seleção do terceiro mux (entrada para register file) */
    wire [2:0] cu_alu_operation;            /* definição da operação da alu */
    wire cu_dm_write_en;                     /* habilita escrita no data_memory */

    /* instanciação da unit under test */
    control_unit uut(
        .clk(clk),
        .instruction(instruction),
        .cu_rf_addr_a(cu_rf_addr_a),
        .cu_rf_addr_b(cu_rf_addr_b),
        .cu_rf_write_addr(cu_rf_write_addr),
        .cu_rf_write_en(cu_rf_write_en),
        .cu_immediate(cu_immediate),
        .cu_mux_0_sel(cu_mux_0_sel),
        .cu_mux_1_sel(cu_mux_1_sel),
        .cu_mux_2_sel(cu_mux_2_sel),
        .cu_alu_operation(cu_alu_operation),
        .cu_dm_write_en(cu_dm_write_en)
    );

    /* instruções */
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

    /* início do testbench */
    initial begin
        
        instruction = instruction_03;
        
        $monitor(
            "clk = %B\n", clk,
            "instruction = %B\n", instruction,
            "cu_rf_addr_a = %B\n", cu_rf_addr_a,
            "cu_rf_addr_b = %B\n", cu_rf_addr_b,
            "cu_rf_write_addr = %B\n", cu_rf_write_addr,
            "cu_rf_write_en = %B\n", cu_rf_write_en,
            "cu_immediate = %B\n", cu_immediate,
            "cu_mux_0_sel = %B\n", cu_mux_0_sel,
            "cu_mux_1_sel = %B\n", cu_mux_1_sel,
            "cu_mux_2_sel = %B\n", cu_mux_2_sel,
            "cu_alu_operation = %B\n", cu_alu_operation,
            "cu_dm_write_en = %B\n", cu_dm_write_en
        );
        #100;

        // clk = 0; #100; clk = 1; #100;
        // clk = 0; #100; clk = 1; #100;

    end
endmodule