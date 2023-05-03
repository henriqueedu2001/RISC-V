/* descrição */
module cpu #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter SIZE = 512               /* tamanho da memória */
) (

    input wire cpu_clk
);
    wire [4:0] cu_rf_addr_a;
    wire [4:0] cu_rf_addr_b;
    wire [4:0] cu_rf_write_addr;
    wire cu_rf_write_en; //cpu_ rf_write_en
    wire [WORDSIZE-1:0] cu_immediate;
    wire cu_mux_0_sel;
    wire cu_mux_1_sel;
    wire cu_mux_2_sel;
    wire [2:0] cu_alu_operation;
    wire cu_dm_write_en;
    
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
    assign alu_operation = cpu_alu_operation;

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