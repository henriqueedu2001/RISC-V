`timescale 1ps/1ps

/* teste do módulo [...] */
module cpu_test #(
    parameter WORDSIZE = 64
) ();
    reg [4:0] cpu_rf_addr_a;
    reg [4:0] cpu_rf_addr_b;
    reg [4:0] cpu_rf_write_addr;
    reg cpu_rf_write_en;
    reg [WORDSIZE-1:0] cpu_immediate;
    reg cpu_mux_0_sel;
    reg cpu_mux_1_sel;
    reg cpu_mux_2_sel;
    reg [2:0] cpu_alu_operation;
    reg cpu_dm_write_en;
    reg cpu_clk;

    /* sinais de leitura */
    wire [WORDSIZE-1:0] cpu_reading_rf_data_a;
    wire [WORDSIZE-1:0] cpu_reading_rf_data_b;
    wire [WORDSIZE-1:0] cpu_reading_alu_result;
    wire [WORDSIZE-1:0] cpu_reading_dm_data_output;
    output wire [WORDSIZE-1:0] cpu_reading_mux_0_out;
    output wire [WORDSIZE-1:0] cpu_reading_mux_1_out;
    output wire [WORDSIZE-1:0] cpu_reading_mux_2_out;

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
        .cpu_clk(cpu_clk),
        .cpu_reading_rf_data_a(cpu_reading_rf_data_a),
        .cpu_reading_rf_data_b(cpu_reading_rf_data_b),
        .cpu_reading_alu_result(cpu_reading_alu_result),
        .cpu_reading_dm_data_output(cpu_reading_dm_data_output),
        .cpu_reading_mux_0_out(cpu_reading_mux_0_out),
        .cpu_reading_mux_1_out(cpu_reading_mux_1_out),
        .cpu_reading_mux_2_out(cpu_reading_mux_2_out)
    );

    /* início do testbench */
    initial begin
        /* teste de instrução load word: lw x2, #5(x7) */
        cpu_clk = 0;
        cpu_rf_addr_a = 7;     /* recebe x7 */
        cpu_rf_addr_b = 2;     /* (opcional) para acompanhar os valores de x2 */
        cpu_rf_write_addr = 2; /* recebe x2 */
        cpu_rf_write_en = 1;   /* ativa escrita no register file*/
        cpu_immediate = 5;     /* valor do immediate */
        cpu_mux_0_sel = 0;     /* seleciona o x7 */
        cpu_mux_1_sel = 0;     /* seleciona o immediate */
        cpu_mux_2_sel = 0;     /* seleciona a soma feita na alu */
        cpu_alu_operation = 0; /* soma x7 com immediate */
        cpu_dm_write_en = 0;   /* desativa escrita no data memory */

        $monitor("rf_data_a = %H\nrf_data_b = %H\nalu_result = %H\ndm_data_output = %H\nmux_0 = %H\nmux_1 = %H\nmux_2 = %H\n",
            cpu_reading_rf_data_a,
            cpu_reading_rf_data_b,
            cpu_reading_alu_result,
            cpu_reading_dm_data_output,
            cpu_reading_mux_0_out,
            cpu_reading_mux_1_out,
            cpu_reading_mux_2_out
        );
        #100;

        $monitor("rf_data_a = %H\nrf_data_b = %H\nalu_result = %H\ndm_data_output = %H\nmux_0 = %H\nmux_1 = %H\nmux_2 = %H\n",
            cpu_reading_rf_data_a,
            cpu_reading_rf_data_b,
            cpu_reading_alu_result,
            cpu_reading_dm_data_output,
            cpu_reading_mux_0_out,
            cpu_reading_mux_1_out,
            cpu_reading_mux_2_out
        );

        cpu_clk = 1;
        #100;

        $monitor("rf_data_a = %H\nrf_data_b = %H\nalu_result = %H\ndm_data_output = %H\nmux_0 = %H\nmux_1 = %H\nmux_2 = %H\n",
            cpu_reading_rf_data_a,
            cpu_reading_rf_data_b,
            cpu_reading_alu_result,
            cpu_reading_dm_data_output,
            cpu_reading_mux_0_out,
            cpu_reading_mux_1_out,
            cpu_reading_mux_2_out
        );

        cpu_clk = 0;
        #100;

        $monitor("rf_data_a = %H\nrf_data_b = %H\nalu_result = %H\ndm_data_output = %H\nmux_0 = %H\nmux_1 = %H\nmux_2 = %H\n",
            cpu_reading_rf_data_a,
            cpu_reading_rf_data_b,
            cpu_reading_alu_result,
            cpu_reading_dm_data_output,
            cpu_reading_mux_0_out,
            cpu_reading_mux_1_out,
            cpu_reading_mux_2_out
        );


    end
endmodule