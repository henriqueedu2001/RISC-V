`timescale 1ps/1ps

/* teste do módulo [...] */
module cpu_test #(
    parameter WORDSIZE = 64,
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) ();

    reg cpu_clk;
    reg pc_clk;
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
        .cpu_clk(cpu_clk),
        .pc_clk(pc_clk),
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
        cpu_clk = 0;
        pc_clk = 0;

        /* teste da instrução de load */
        $monitor(
            "---LOAD INSTRUCTION TEST BEGIN---\n\n",
            "control signals:\n",
            "   -> cpu_reading_im_instr = %H\n", cpu_reading_im_instr,
            "   -> cpu_reading_pc_addr = %H\n", cpu_reading_pc_addr,
            "   -> cpu_reading_rf_data_a = %H\n", cpu_reading_rf_data_a,
            "   -> cpu_reading_rf_data_b = %H\n", cpu_reading_rf_data_b,
            "   -> cpu_reading_dm_data_out = %H\n", cpu_reading_dm_data_out,
            "   -> cpu_reading_mux_0_out = %H\n", cpu_reading_mux_0_out,
            "   -> cpu_reading_mux_1_out = %H\n", cpu_reading_mux_1_out,
            "   -> cpu_reading_mux_2_out = %H\n", cpu_reading_mux_2_out
        );
        #100;

        
        #100; cpu_clk = 0;
        $monitor("(register file) register value: %H", cpu_reading_rf_data_b);

        #100; cpu_clk = 1;
        $monitor("(register file) register value: %H", cpu_reading_rf_data_b);

        #100; cpu_clk = 0;
        $monitor("\n---LOAD INSTRUCTION TEST BEGIN---\n"); #100;

        #100; pc_clk = 1;
        #100; pc_clk = 0;

        /* teste da instrução de store */
        $monitor(
            "---STORE INSTRUCTION TEST BEGIN---\n\n",
            "control signals:\n",
            "   -> cpu_reading_im_instr = %H\n", cpu_reading_im_instr,
            "   -> cpu_reading_pc_addr = %H\n", cpu_reading_pc_addr,
            "   -> cpu_reading_rf_data_a = %H\n", cpu_reading_rf_data_a,
            "   -> cpu_reading_rf_data_b = %H\n", cpu_reading_rf_data_b,
            "   -> cpu_reading_dm_data_out = %H\n", cpu_reading_dm_data_out,
            "   -> cpu_reading_mux_0_out = %H\n", cpu_reading_mux_0_out,
            "   -> cpu_reading_mux_1_out = %H\n", cpu_reading_mux_1_out,
            "   -> cpu_reading_mux_2_out = %H\n", cpu_reading_mux_2_out
        );
        #100;

        $monitor("---STORE INSTRUCTION TEST END---\n"); #100;

        #100; pc_clk = 1;
        #100; pc_clk = 0;

        /* teste da instrução add */
        $monitor(
            "---ADD INSTRUCTION TEST BEGIN---\n\n",
            "control signals:\n",
            "   -> cpu_reading_im_instr = %H\n", cpu_reading_im_instr,
            "   -> cpu_reading_pc_addr = %H\n", cpu_reading_pc_addr,
            "   -> cpu_reading_rf_data_a = %H\n", cpu_reading_rf_data_a,
            "   -> cpu_reading_rf_data_b = %H\n", cpu_reading_rf_data_b,
            "   -> cpu_reading_dm_data_out = %H\n", cpu_reading_dm_data_out,
            "   -> cpu_reading_mux_0_out = %H\n", cpu_reading_mux_0_out,
            "   -> cpu_reading_mux_1_out = %H\n", cpu_reading_mux_1_out,
            "   -> cpu_reading_mux_2_out = %H\n", cpu_reading_mux_2_out
        );
        #100;

        $monitor("---ADD INSTRUCTION TEST END---\n"); #100;

        #100; pc_clk = 1;
        #100; pc_clk = 0;

        /* teste da instrução sub */
        $monitor(
            "---SUB INSTRUCTION TEST BEGIN---\n\n",
            "control signals:\n",
            "   -> cpu_reading_im_instr = %H\n", cpu_reading_im_instr,
            "   -> cpu_reading_pc_addr = %H\n", cpu_reading_pc_addr,
            "   -> cpu_reading_rf_data_a = %H\n", cpu_reading_rf_data_a,
            "   -> cpu_reading_rf_data_b = %H\n", cpu_reading_rf_data_b,
            "   -> cpu_reading_dm_data_out = %H\n", cpu_reading_dm_data_out,
            "   -> cpu_reading_mux_0_out = %H\n", cpu_reading_mux_0_out,
            "   -> cpu_reading_mux_1_out = %H\n", cpu_reading_mux_1_out,
            "   -> cpu_reading_mux_2_out = %H\n", cpu_reading_mux_2_out
        );
        #100;

        $monitor("---SUB INSTRUCTION TEST END---\n"); #100;

        #100; pc_clk = 1;
        #100; pc_clk = 0;

        /* teste da instrução addi */
        $monitor(
            "---ADDi INSTRUCTION TEST BEGIN---\n\n",
            "control signals:\n",
            "   -> cpu_reading_im_instr = %H\n", cpu_reading_im_instr,
            "   -> cpu_reading_pc_addr = %H\n", cpu_reading_pc_addr,
            "   -> cpu_reading_rf_data_a = %H\n", cpu_reading_rf_data_a,
            "   -> cpu_reading_rf_data_b = %H\n", cpu_reading_rf_data_b,
            "   -> cpu_reading_dm_data_out = %H\n", cpu_reading_dm_data_out,
            "   -> cpu_reading_mux_0_out = %H\n", cpu_reading_mux_0_out,
            "   -> cpu_reading_mux_1_out = %H\n", cpu_reading_mux_1_out,
            "   -> cpu_reading_mux_2_out = %H\n", cpu_reading_mux_2_out
        );
        #100;

        $monitor("---ADDi INSTRUCTION TEST END---\n"); #100;

        #100; pc_clk = 1;
        #100; pc_clk = 0;

        /* teste da instrução subi */
        $monitor(
            "---SUB iINSTRUCTION TEST BEGIN---\n\n",
            "control signals:\n",
            "   -> cpu_reading_im_instr = %H\n", cpu_reading_im_instr,
            "   -> cpu_reading_pc_addr = %H\n", cpu_reading_pc_addr,
            "   -> cpu_reading_rf_data_a = %H\n", cpu_reading_rf_data_a,
            "   -> cpu_reading_rf_data_b = %H\n", cpu_reading_rf_data_b,
            "   -> cpu_reading_dm_data_out = %H\n", cpu_reading_dm_data_out,
            "   -> cpu_reading_mux_0_out = %H\n", cpu_reading_mux_0_out,
            "   -> cpu_reading_mux_1_out = %H\n", cpu_reading_mux_1_out,
            "   -> cpu_reading_mux_2_out = %H\n", cpu_reading_mux_2_out
        );
        #100;

        $monitor("---SUBi INSTRUCTION TEST END---"); #100;

    end
endmodule