`timescale 1ps/1ps

/* teste do módulo [...] */
module cpu_test #(
    parameter WORDSIZE = 64
) ();
    reg [4:0] cpu_rf_addr_a;
    reg [4:0] cpu_rf_addr_b;
    reg [4:0] cpu_rf_write_addr;
    reg cpu_rf_write_en;
    reg [11:0] cpu_immediate;
    reg cpu_mux_0_sel;
    reg cpu_mux_1_sel;
    reg cpu_mux_2_sel;
    reg [2:0] cpu_alu_operation;
    reg cpu_clk;

    /* instanciação da unit under test */
    cpu uut(
        .cpu_rf_addr_a(cpu_rf_addr_a),
        .cpu_rf_addr_b(cpu_rf_addr_b),
        .cpu_rf_write_addr(cpu_rf_write_addr),
        .cpu_rf_write_en(cpu_rf_write_en),
        .cpu_immediate(cpu_immediate),
        .cpu_mux_0_sel(cpu_mux_0_sel),
        .cpu_mux_1_sel(cpu_mux_1_sel),
        .cpu_mux_2_sel(cpu_mux_2_sel),
        .cpu_alu_operation(cpu_alu_operation),
        .cpu_clk(cpu_clk)
    );

    /* início do testbench */
    initial begin
        /*  */
    end
endmodule