/* descrição */
module processor #(
    parameter i_addr_bits = 6,
    parameter d_addr_bits = 6,
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
    ) (
    input clk, rst_n,
    output [i_addr_bits-1:0] i_mem_addr,
    input [31:0] i_mem_data,
    output d_mem_we,
    output [d_addr_bits-1:0] d_mem_addr,
    inout [63:0] d_mem_data
    );

    // sinais de controle

    wire [6:0] opcode;
    wire rf_we;
    wire [3:0] alu_cmd;
    wire [3:0] alu_flags;
    wire alu_src;
    wire pc_src;
    wire rf_src;

    // clock_gen clock_gen_unit(
    //     .clock(clk)
    // );

    // Instanciacao Datapath
    datapath dapath_unit(
        .clk(clk),
        .rst_n(rst_n),
        .opcode(opcode),
        .d_mem_we(d_mem_we),
        .rf_we(rf_we),
        .alu_cmd(alu_cmd),
        .alu_flags(alu_flags),
        .alu_src(alu_src),
        .pc_src(pc_src),
        .rf_src(rf_src),
        .i_mem_addr(i_mem_addr),
        .i_mem_data(i_mem_data),
        .d_mem_addr(d_mem_addr),
        .d_mem_data(d_mem_data)

        
    );

    // Instanciacao Control Unit
    control_unit control_unit_processor(
        .clk(clk),
        .rst_n(rst_n),
        .opcode(opcode),
        .d_mem_we(d_mem_we),
        .rf_we(rf_we),
        .alu_flags(alu_flags),
        .alu_cmd(alu_cmd),
        .alu_src(alu_src),
        .pc_src(pc_src),
        .rf_src(rf_src)
    );

endmodule