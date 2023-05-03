`timescale 1ps/1ps

/* teste do módulo [...] */
module cpu_test #(
    parameter WORDSIZE = 64,
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) ();
    reg clk;
    wire [WORDSIZE-1:0] cpu_reading_rf_data_a;
    wire [WORDSIZE-1:0] cpu_reading_rf_data_b;
    wire [WORDSIZE-1:0] cpu_reading_dm_data_out;
    wire [WORDSIZE-1:0] cpu_reading_mux_0_out;
    wire [WORDSIZE-1:0] cpu_reading_mux_1_out;
    wire [WORDSIZE-1:0] cpu_reading_mux_2_out;
    wire [INSTRUCTION_SIZE-1:0] cpu_reading_im_instr;
    wire [WORDSIZE-1:0] cpu_reading_pc_addr;

    /* instanciação da unit under test */
    cpu uut(
        .cpu_clk(clk),
        .cpu_reading_rf_data_a(cpu_reading_rf_data_a),
        .cpu_reading_rf_data_b(cpu_reading_rf_data_b),
        .cpu_reading_dm_data_out(cpu_reading_dm_data_out),
        .cpu_reading_mux_0_out(cpu_reading_mux_0_out),
        .cpu_reading_mux_1_out(cpu_reading_mux_1_out),
        .cpu_reading_mux_2_out(cpu_reading_mux_2_out),
        .cpu_reading_im_instr(cpu_reading_im_instr),
        .cpu_reading_pc_addr(cpu_reading_pc_addr)
    );

    /* início do testbench */
    initial begin
        $monitor(
            "cpu_reading_rf_data_a = %H\n", cpu_reading_rf_data_a,
            "cpu_reading_rf_data_b = %H\n", cpu_reading_rf_data_b,
            "cpu_reading_dm_data_out = %H\n", cpu_reading_dm_data_out,
            "cpu_reading_mux_0_out = %H\n", cpu_reading_mux_0_out,
            "cpu_reading_mux_1_out = %H\n", cpu_reading_mux_1_out,
            "cpu_reading_mux_2_out = %H\n", cpu_reading_mux_2_out,
            "cpu_reading_im_instr = %H\n", cpu_reading_im_instr,
            "cpu_reading_pc_addr = %H\n", cpu_reading_pc_addr
        );
    end
endmodule