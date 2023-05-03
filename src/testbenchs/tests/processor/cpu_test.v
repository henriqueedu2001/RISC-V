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
        .cpu_dm_write_en(cpu_dm_write_en),
        .cpu_reading_mux_0_out(cpu_reading_mux_0_out),
        .cpu_reading_mux_1_out(cpu_reading_mux_1_out),
        .cpu_reading_mux_2_out(cpu_reading_mux_2_out)
    );

    /* início do testbench */
    initial begin
        /* teste de instrução load word: lw x2, #5(x7) */
        cpu_rf_addr_a = 5'b00111;                   /* recebe x7 */
        cpu_rf_addr_b = 5'b00010;                   /* (opcional) para acompanhar os valores de x2 */
        cpu_rf_write_addr = 5'b00010;               /* recebe x2 */
        cpu_rf_write_en = 1;                        /* ativa escrita no register file */
        cpu_immediate = 64'h0000_0000_0000_0005;    /* valor do immediate = 5 */
        cpu_mux_0_sel = 0;                          /* seleciona o x7 */
        cpu_mux_1_sel = 0;                          /* seleciona o immediate */
        cpu_mux_2_sel = 0;                          /* seleciona a soma feita na alu */
        cpu_alu_operation = 3'b000;                 /* soma x7 com immediate */
        cpu_dm_write_en = 0;                        /* desativa escrita no data memory */
        
        $monitor("--LOAD INSTRUCTION TEST BEGIN--\n\n",
            "instruction: lw x2, #5(x7)\n", 
            "parameters:\n",
            "   -cpu_rf_addr_a = %B", cpu_rf_addr_a, "\n",
            "   -cpu_rf_addr_b = %B", cpu_rf_addr_b, "\n",
            "   -cpu_rf_write_addr = %B", cpu_rf_write_addr, "\n",
            "   -cpu_rf_write_en = %B", cpu_rf_write_en, "\n",
            "   -cpu_immediate = %H", cpu_immediate, "\n",
            "   -cpu_mux_0_sel = %B", cpu_mux_0_sel, "\n",
            "   -cpu_mux_1_sel = %B", cpu_mux_1_sel, "\n",
            "   -cpu_mux_2_sel = %B", cpu_mux_2_sel, "\n",
            "   -cpu_alu_operation = %B", cpu_alu_operation, "\n",
            "   -cpu_dm_write_en = %B", cpu_dm_write_en, "\n"
        );
        #100;

        $monitor("clk = %B; x2 = %H", cpu_clk, cpu_reading_rf_data_b);
        cpu_clk = 0; #100;
        $monitor("clk = %B; x2 = %H", cpu_clk, cpu_reading_rf_data_b);
        cpu_clk = 1; #100;
        $monitor("clk = %B; x2 = %H", cpu_clk, cpu_reading_rf_data_b);
        cpu_clk = 0; #100;

        $monitor("\n--LOAD INSTRUCTION TEST END--\n");
        #100;

        /* teste de instrução store word: sw x4, #23(x2) */
        cpu_rf_addr_a = 5'b00100;                   /* recebe x4 */
        cpu_rf_addr_b = 5'b00010;                   /* recebe x2 */
        cpu_rf_write_addr = 5'b00000;               /* irrelevante */
        cpu_rf_write_en = 0;                        /* desativa escrita no register file */
        cpu_immediate = 64'h0000_0000_0000_0017;    /* valor do immediate = 23 */
        cpu_mux_0_sel = 1;                          /* seleciona o x2 */
        cpu_mux_1_sel = 0;                          /* seleciona o immediate */
        cpu_mux_2_sel = 0;                          /* irrelevante */
        cpu_alu_operation = 3'b000;                 /* soma x7 com immediate */
        cpu_dm_write_en = 1;                        /* ativa escrita no data memory */
        
        $monitor("--STORE INSTRUCTION TEST BEGIN--\n\n",
            "instruction: sw x4, #23(x8)\n", 
            "parameters:\n",
            "   -cpu_rf_addr_a = %B", cpu_rf_addr_a, "\n",
            "   -cpu_rf_addr_b = %B", cpu_rf_addr_b, "\n",
            "   -cpu_rf_write_addr = %B", cpu_rf_write_addr, "\n",
            "   -cpu_rf_write_en = %B", cpu_rf_write_en, "\n",
            "   -cpu_immediate = %H", cpu_immediate, "\n",
            "   -cpu_mux_0_sel = %B", cpu_mux_0_sel, "\n",
            "   -cpu_mux_1_sel = %B", cpu_mux_1_sel, "\n",
            "   -cpu_mux_2_sel = %B", cpu_mux_2_sel, "\n",
            "   -cpu_alu_operation = %B", cpu_alu_operation, "\n",
            "   -cpu_dm_write_en = %B", cpu_dm_write_en, "\n"
        );
        #100;

        $monitor("clk = %B; mem[4] = %H", cpu_clk, cpu_reading_dm_data_output);
        cpu_clk = 0; #100;
        $monitor("clk = %B; mem[4] = %H", cpu_clk, cpu_reading_dm_data_output);
        cpu_clk = 1; #100;
        $monitor("clk = %B; mem[4] = %H", cpu_clk, cpu_reading_dm_data_output);
        cpu_clk = 0; #100;

        $monitor("\n--STORE INSTRUCTION TEST END--\n");
        #100;

        /* teste de instrução add: add x1, x2, x0 */
        cpu_rf_addr_a = 5'b00010;                   /* recebe x2 */
        cpu_rf_addr_b = 5'b00000;                   /* recebe x0 */
        cpu_rf_write_addr = 5'b00001;               /* recebe x1 */
        cpu_rf_write_en = 1;                        /* ativa escrita no register file */
        cpu_immediate = 64'h0000_0000_0000_0000;    /* irrelevante */
        cpu_mux_0_sel = 0;                          /* seleciona o x2 */
        cpu_mux_1_sel = 1;                          /* seleciona o x0 */
        cpu_mux_2_sel = 0;                          /* seleciona a soma feita na alu */
        cpu_alu_operation = 3'b000;                 /* soma x7 com immediate */
        cpu_dm_write_en = 0;                        /* desativa escrita no data memory */
        
        $monitor("--ADD INSTRUCTION TEST BEGIN--\n\n",
            "instruction: add x1, x2, x0\n", 
            "parameters:\n",
            "   -cpu_rf_addr_a = %B", cpu_rf_addr_a, "\n",
            "   -cpu_rf_addr_b = %B", cpu_rf_addr_b, "\n",
            "   -cpu_rf_write_addr = %B", cpu_rf_write_addr, "\n",
            "   -cpu_rf_write_en = %B", cpu_rf_write_en, "\n",
            "   -cpu_immediate = %H", cpu_immediate, "\n",
            "   -cpu_mux_0_sel = %B", cpu_mux_0_sel, "\n",
            "   -cpu_mux_1_sel = %B", cpu_mux_1_sel, "\n",
            "   -cpu_mux_2_sel = %B", cpu_mux_2_sel, "\n",
            "   -cpu_alu_operation = %B", cpu_alu_operation, "\n",
            "   -cpu_dm_write_en = %B", cpu_dm_write_en, "\n"
        );
        #100;

        cpu_clk = 0; #100;
        cpu_clk = 1; #100;
        cpu_clk = 0; #100;

        cpu_rf_addr_a = 5'b00001;
        $monitor("clk = %B; x1 = %H", cpu_clk, cpu_reading_rf_data_a);
        #100;

        $monitor("\n--ADD INSTRUCTION TEST END--\n");
        #100;

        /* teste de instrução sub: sub x1, x0, x2 */
        cpu_rf_addr_a = 5'b00000;                   /* recebe x0 */
        cpu_rf_addr_b = 5'b00010;                   /* recebe x2 */
        cpu_rf_write_addr = 5'b00001;               /* recebe x1 */
        cpu_rf_write_en = 1;                        /* ativa escrita no register file */
        cpu_immediate = 64'h0000_0000_0000_0000;    /* irrelevante */
        cpu_mux_0_sel = 0;                          /* seleciona o x0 */
        cpu_mux_1_sel = 1;                          /* seleciona o x2 */
        cpu_mux_2_sel = 0;                          /* seleciona a subtração feita na alu */
        cpu_alu_operation = 3'b001;                 /* subtração dos operandos */
        cpu_dm_write_en = 0;                        /* desativa escrita no data memory */
        
        $monitor("--SUB INSTRUCTION TEST BEGIN--\n\n",
            "instruction: sub x1, x0, x2\n", 
            "parameters:\n",
            "   -cpu_rf_addr_a = %B", cpu_rf_addr_a, "\n",
            "   -cpu_rf_addr_b = %B", cpu_rf_addr_b, "\n",
            "   -cpu_rf_write_addr = %B", cpu_rf_write_addr, "\n",
            "   -cpu_rf_write_en = %B", cpu_rf_write_en, "\n",
            "   -cpu_immediate = %H", cpu_immediate, "\n",
            "   -cpu_mux_0_sel = %B", cpu_mux_0_sel, "\n",
            "   -cpu_mux_1_sel = %B", cpu_mux_1_sel, "\n",
            "   -cpu_mux_2_sel = %B", cpu_mux_2_sel, "\n",
            "   -cpu_alu_operation = %B", cpu_alu_operation, "\n",
            "   -cpu_dm_write_en = %B", cpu_dm_write_en, "\n"
        );
        #100;

        cpu_clk = 0; #100;
        cpu_clk = 1; #100;
        cpu_clk = 0; #100;

        cpu_rf_addr_a = 5'b00001;
        $monitor("clk = %B; x1 = %H", cpu_clk, cpu_reading_rf_data_a);
        #100;

        $monitor("\n--SUB INSTRUCTION TEST END--\n");
        #100;
    end
endmodule