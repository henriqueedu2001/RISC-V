/* descrição */
module cpu #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter SIZE = 512               /* tamanho da memória */
) (
    input wire [4:0] cpu_rf_addr_a,
    input wire [4:0] cpu_rf_addr_b,
    input wire [4:0] cpu_rf_write_addr,
    input wire cpu_rf_write_en,
    input wire [11:0] cpu_immediate,
    input wire cpu_mux_0_sel,
    input wire cpu_mux_1_sel,
    input wire cpu_mux_2_sel,
    input wire [2:0] cpu_alu_operation,
    input wire cpu_clk
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

    register_file rf_inst (
        .clk(clk),
        .addr_a(rf_addr_a),
        .addr_b(rf_addr_b),
        .write_en(rf_write_en),
        .write_addr(rf_write_addr),
        .write_data(rf_write_data),
        .data_a(rf_data_a),
        .data_b(rf_data_b)
    );

    data_memory dm_inst (
        .clk(clk),
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

    

endmodule