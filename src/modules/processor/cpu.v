/* descrição */
module cpu #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter SIZE = 512,              /* tamanho da memória */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) (
    input wire cpu_clk,                  /* sinal de clock */
    output wire [WORDSIZE-1:0] cpu_reading_rf_data_a,   /* leitura do register file data_a */
    output wire [WORDSIZE-1:0] cpu_reading_rf_data_b,   /* leitura do register file data_b */
    output wire [WORDSIZE-1:0] cpu_reading_dm_data_out, /* leitura do data_output do data memory */
    output wire [WORDSIZE-1:0] cpu_reading_mux_0_out,   /* leitura da saída do mux_0 */
    output wire [WORDSIZE-1:0] cpu_reading_mux_1_out,   /* leitura da saída do mux_1 */
    output wire [WORDSIZE-1:0] cpu_reading_mux_2_out,   /* leitura da saída do mux_2 */
    output wire [INSTRUCTION_SIZE-1:0] cpu_reading_im_instr,     /* leitura da instrução do im */
    output wire [WORDSIZE-1:0] cpu_reading_pc_addr      /* leitura do endereço do pc */
);
    
    /* fios do register file */
    wire [4:0] rf_addr_a;
    wire [4:0] rf_addr_b;
    wire rf_write_en;
    wire [4:0] rf_write_addr;
    wire [WORDSIZE-1:0] rf_write_data;
    wire [WORDSIZE-1:0] rf_data_a;
    wire [WORDSIZE-1:0] rf_data_b;

    /* fios do data memory */
    wire [WORDSIZE-1:0] dm_addr;
    wire [WORDSIZE-1:0] dm_data_input;
    wire dm_write_en;
    wire [WORDSIZE-1:0] dm_data_output;

    /* fios da alu */
    wire [WORDSIZE-1:0] alu_input_a;
    wire [WORDSIZE-1:0] alu_input_b;
    wire [2:0] alu_operation;
    wire [WORDSIZE-1:0] alu_result;
    wire alu_overflow;

    /* fios da unidade de controle */
    wire [WORDSIZE-1:0] cu_instruction;     /* instrução para unidade de controle */
    wire [4:0] cu_rf_addr_a;                /* seleção de addr_a no register file */
    wire [4:0] cu_rf_addr_b;                /* seleção de addr_b no register file */
    wire [4:0] cu_rf_write_addr;            /* seleção de write_addr no register file */
    wire cu_rf_write_en;                    /* habilita escrita no register file */
    wire [WORDSIZE-1:0] cu_immediate;       /* immediate da instrução */
    wire cu_mux_0_sel;                      /* seleção do primeiro mux (entrada para alu) */
    wire cu_mux_1_sel;                      /* seleção do segundo mux (entrada para alu) */
    wire cu_mux_2_sel;                      /* seleção do terceiro mux (entrada para register file) */
    wire [2:0] cu_alu_operation;            /* definição da operação da alu */
    wire cu_dm_write_en;                    /* habilita escrita no data_memory */

    /* fios do instruction memory */
    wire [INSTRUCTION_SIZE-1:0] im_instruction;
    wire [WORDSIZE-1:0] im_addr;

    /* fios do program counter */
    wire [WORDSIZE-1:0] pc_addr;

    /* fios dos multiplexadores */
    wire mux_0_sel;
    wire [WORDSIZE-1:0] mux_0_input_a;
    wire [WORDSIZE-1:0] mux_0_input_b;
    wire [WORDSIZE-1:0] mux_0_out;

    wire mux_1_sel;
    wire [WORDSIZE-1:0] mux_1_input_a;
    wire [WORDSIZE-1:0] mux_1_input_b;
    wire [WORDSIZE-1:0] mux_1_out;

    wire mux_2_sel;
    wire [WORDSIZE-1:0] mux_2_input_a;
    wire [WORDSIZE-1:0] mux_2_input_b;
    wire [WORDSIZE-1:0] mux_2_out;

    /* entradas no register file */
    assign rf_addr_a = cu_rf_addr_a;
    assign rf_addr_b = cu_rf_addr_b;
    assign rf_write_addr = cu_rf_write_addr;
    assign rf_write_en = cu_rf_write_en;
    assign rf_write_data = mux_2_out;

    /* entradas no data memory */
    assign dm_addr = alu_result;
    assign dm_data_input = rf_data_b;
    assign dm_write_en = cu_dm_write_en;

    /* entradas na alu */
    assign alu_input_a = mux_0_out;
    assign alu_input_b = mux_1_out;
    /* assign alu_operation = cpu_alu_operation; */ // TODO

    /* entradas da control unit */
    assign cu_instruction = im_instruction;

    /* entradas do program counter */
    // assign pc_addr = ;

    /* entradas nos multiplexadores */
    assign mux_0_input_a = rf_data_a;
    assign mux_0_input_b = rf_data_b;
    assign mux_0_sel = cu_mux_0_sel;

    assign mux_1_input_a = cu_immediate;
    assign mux_1_input_b = rf_data_b;
    assign mux_1_sel = cu_mux_1_sel;

    assign mux_2_input_a = alu_result;
    assign mux_2_input_b = dm_data_output;
    assign mux_2_sel = cu_mux_2_sel;

    /* sinais de leitura */
    assign cpu_reading_rf_data_a = rf_data_a;
    assign cpu_reading_rf_data_b = rf_data_b;
    assign cpu_reading_dm_data_out = dm_data_output;
    assign cpu_reading_mux_0_out = mux_0_out;
    assign cpu_reading_mux_1_out = mux_1_out;
    assign cpu_reading_mux_2_out = mux_2_out;
    assign cpu_reading_im_instr = im_instruction;
    assign cpu_reading_pc_addr = pc_addr;

    register_file rf_inst (
        .clk(cpu_clk),
        .addr_a(rf_addr_a),
        .addr_b(rf_addr_b),
        .write_en(rf_write_en),
        .write_addr(rf_write_addr),
        .write_data(rf_write_data),
        .data_a(rf_data_a),
        .data_b(rf_data_b)
    );

    data_memory dm_inst (
        .clk(cpu_clk),
        .addr(dm_addr),
        .data_input(dm_data_input),
        .write_en(dm_write_en),
        .data_output(dm_data_output)
    );
    
    alu alu_inst (
        .input_a(alu_input_a),
        .input_b(alu_input_b),
        .operation(alu_operation),
        .result(alu_result),
        .overflow(alu_overflow)
    );

    control_unit cu(
        .clk(cpu_clk),
        .instruction(im_instruction), 
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

    program_counter pc(
        .clk(cpu_clk),
        .addr(pc_addr)
    );

    instruction_memory im(
        .instruction(im_instruction),
        .addr(im_addr)
    );

    general_mux mux_0(
        .input_a(mux_0_input_a),
        .input_b(mux_0_input_b),
        .sel(mux_0_sel),
        .out(mux_0_out)
    );

    general_mux mux_1(
        .input_a(mux_1_input_a),
        .input_b(mux_1_input_b),
        .sel(mux_1_sel),
        .out(mux_1_out)
    );

    general_mux mux_2(
        .input_a(mux_2_input_a),
        .input_b(mux_2_input_b),
        .sel(mux_2_sel),
        .out(mux_2_out)
    );




endmodule