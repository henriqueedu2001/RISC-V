`timescale 1ps/1ps

/* teste do módulo [...] */
module cpu_test #(
    parameter WORDSIZE = 64
) ();
    /* fios do register file */
    reg clk;
    reg [4:0] rf_addr_a;
    reg [4:0] rf_addr_b;
    reg rf_write_en;
    reg [4:0] rf_write_addr;
    reg [WORDSIZE-1:0] rf_write_data;
    wire [WORDSIZE-1:0] rf_data_a;
    wire [WORDSIZE-1:0] rf_data_b;

    /* fios do data memory */
    reg [WORDSIZE-1:0] dm_addr;
    reg [WORDSIZE-1:0] dm_data_input;
    reg dm_write_en;
    wire [WORDSIZE-1:0] dm_data_output;

    /* fios da alu */
    reg [WORDSIZE-1:0] alu_input_a;
    reg [WORDSIZE-1:0] alu_input_b;
    reg [2:0] alu_operation;
    wire [WORDSIZE-1:0] alu_result;
    wire alu_overflow;

    /* instanciação da unit under test */
    cpu uut(
        .clk(clk),
        .rf_addr_a(rf_addr_a),
        .rf_addr_b(rf_addr_b),
        .rf_write_en(rf_write_en),
        .rf_write_addr(rf_write_addr),
        .rf_write_data(rf_write_data),
        .rf_data_a(rf_data_a),
        .rf_data_b(rf_data_b),
        .dm_addr(dm_addr),
        .dm_data_input(dm_data_input),
        .dm_write_en(dm_write_en),
        .dm_data_output(dm_data_output),
        .alu_input_a(alu_input_a),
        .alu_input_b(alu_input_b),
        .alu_operation(alu_operation),
        .alu_result(alu_result),
        .alu_overflow(alu_overflow)
    );

    /* início do testbench */
    initial begin
        rf_addr_a = 1;
        rf_addr_b = 3;
        $monitor("%H\n%H", rf_data_a, rf_data_b);
        clk = 0;
        rf_write_addr = 3;
        rf_write_data = 72;
        rf_write_en = 1;
        #100;

        clk = 1;
        #100;
        clk = 0;
        #100;

        $monitor("%H\n%H", rf_data_a, rf_data_b);
        #100;
    end
endmodule