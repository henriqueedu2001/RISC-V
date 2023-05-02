/* descrição */
module cpu #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter SIZE = 512               /* tamanho da memória */
) (
    input wire [4:0] cpu_rf_addr_a,
    input wire [4:0] cpu_rf_addr_b,
    input wire [4:0] cpu_rf_write_addr,
    input wire cpu_rf_write_en,
    input wire [WORDSIZE-1:0] cpu_immediate,
    input wire cpu_mux_0_sel,
    input wire cpu_mux_1_sel,
    input wire cpu_mux_2_sel,
    input wire [2:0] cpu_alu_operation,
    input wire cpu_dm_write_en,
    input wire cpu_clk,
    output wire [WORDSIZE-1:0] cpu_reading_rf_data_a,
    output wire [WORDSIZE-1:0] cpu_reading_rf_data_b,
    output wire [WORDSIZE-1:0] cpu_reading_alu_result,
    output wire [WORDSIZE-1:0] cpu_reading_dm_data_output,
    output wire [WORDSIZE-1:0] cpu_reading_mux_0_out,
    output wire [WORDSIZE-1:0] cpu_reading_mux_1_out,
    output wire [WORDSIZE-1:0] cpu_reading_mux_2_out
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
    assign rf_addr_a = cpu_rf_addr_a;
    assign rf_addr_b = cpu_rf_addr_b;
    assign rf_write_addr = cpu_rf_write_addr;
    assign rf_write_en = cpu_rf_write_en;
    assign rf_write_data = mux_2_out;

    /* entradas no data memory */
    assign dm_addr = alu_result;
    assign dm_data_input = rf_data_b;
    assign dm_write_en = cpu_dm_write_en;

    /* entradas na alu */
    assign alu_input_a = mux_0_out;
    assign alu_input_b = mux_1_out;
    assign alu_operation = cpu_alu_operation;

    /* entradas nos multiplexadores */
    assign mux_0_input_a = rf_data_a;
    assign mux_0_input_b = rf_data_b;
    assign mux_0_sel = cpu_mux_0_sel;

    assign mux_1_input_a = cpu_immediate;
    assign mux_1_input_b = rf_data_b;
    assign mux_1_sel = cpu_mux_1_sel;

    assign mux_2_input_a = alu_result;
    assign mux_2_input_b = dm_data_output;
    assign mux_2_sel = cpu_mux_2_sel;

    /* sinais de leitura */
    assign cpu_reading_rf_data_a = rf_data_a;
    assign cpu_reading_rf_data_b = rf_data_b;
    assign cpu_reading_alu_result = alu_result;
    assign cpu_reading_dm_data_output = dm_data_output;
    assign cpu_reading_mux_0_out = mux_0_out;
    assign cpu_reading_mux_1_out = mux_1_out;
    assign cpu_reading_mux_2_out = mux_2_out;

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