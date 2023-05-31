/* descrição */
module processor #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) (

);

wire finished;
wire rf_write_en;
wire dm_write_en;
wire [6:0] opcode;
wire clk;
wire [WORDSIZE-1:0] result;

clock_gen clock_gen_unit(
    .clock(clk)
);

// Instanciacao Datapath
datapath dapath_unit(
    .clk(clk),
    .finished(finished),
    .rf_write_en(rf_write_en),
    .dm_write_en(dm_write_en),
    .opcode(opcode),
    .result(result)
);

// Instanciacao Control Unit
control_unit control_unit_processor(
    .clk(clk),
    .finished(finished),
    .rf_write_en(rf_write_en),
    .dm_write_en(dm_write_en),
    .opcode(opcode)
);


endmodule