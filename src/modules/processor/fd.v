module fd #(
    parameter WORDSIZE = 64,           /* tamanho da palavra (64) */
    parameter INSTRUCTION_SIZE = 32,   /* tamanho da instrução (32 para o RISC-V) */
    parameter i_addr_bits = 6,
    parameter d_addr_bits = 6
)
(
 input clk, rst_n,                     // clock e reset
 output[6:0] opcode,                   // opcode
 input d_mem_we, rf_we,                // sinais de escrita na memória de dados e registradores
 input [3:0] alu_cmd,                  // comando da ALU
 output [3:0] alu_flags,               // flags da ALU
 input  alu_src,                       
        pc_src,                      
        rf_src,                      
 output [i_addr_bits-1:0] i_mem_addr,
 input  [31:0]            i_mem_data,
 output [d_addr_bits-1:0] d_mem_addr,
 inout  [63:0]            d_mem_data
);

 reg  [WORDSIZE-1:0] pc_current;
 wire [WORDSIZE-1:0] pc_next;
 wire [INSTRUCTION_SIZE-1:0] instr;

 // register file
 wire [4:0] rf_write_addr;
 wire [WORDSIZE-1:0] rf_write_data;
 wire [4:0] rf_addr_a;
 wire [WORDSIZE-1:0] rf_data_a;
 wire [4:0] rf_addr_b;
 wire [WORDSIZE-1:0] rf_data_b;

// data memory
 wire [WORDSIZE-1:0] dm_data_output;
 wire [4:0] dm_addr;

 // flags 
 wire flag_overflow;          /* sinal de detecção de overflow */
 wire flag_equal;             /* flag igualdade */
 wire flag_not_equal;         /* flag não igualdade */
 wire flag_greater;           /* flag maior */
 wire flag_less;              /* flag menor */
 wire flag_u_equal;           /* flag igualdade (sem sinal) */
 wire flag_u_greater;         /* flag maior (sem sinal) */
 wire flag_u_less;            /* flag menor (sem sinal) */
 
 // contador i 
 reg [2:0] i;
 
 // PC 
 initial begin
  pc_current = 64'd0;
  i = 3'b0;
 end

 assign dm_addr = instr[31:27];

// Atualizando o PC
 always @(posedge clk, negedge rst_n)
 begin
  
  $display("PC: ------------------------------- %d",pc_current);
  if(!rst_n)
   pc_current <= 64'd0;
  else
  begin
    i = i + 1'b1;
    if(i == 3'b100) begin
      i = 3'b0;
      pc_current <= pc_next;
    end

  end
 end 
   
 // instruction memory
 instruction_memory im(.addr(pc_current),.instruction(instr));

 // register file
 assign rf_addr_a = instr[19:15];
 assign rf_addr_b = instr[24:20];
 assign rf_write_addr = instr[11:7];

 // Multiplexer para o Write Data
 assign rf_write_data = (rf_src ==1'b0) ? alu_result : dm_data_output;
 
 // Instanciacao do Register File
 register_file reg_file
 (
  .clk(clk),
  .write_en(rf_we),
  .write_addr(rf_write_addr),
  .write_data(rf_write_data),
  .addr_a(rf_addr_a),
  .addr_b(rf_addr_b),
  .data_a(rf_data_a),
  .data_b(rf_data_b)
 );

wire [WORDSIZE-1:0] alu_input_b;
wire [WORDSIZE-1:0] alu_result;

// Multiplexer para o alu_input_b
assign alu_input_b = (alu_src==1'b1) ? instr[31:20] : rf_data_b;

// Instanciacao da ALU
alu alu_unit 
(
  .input_a(rf_data_a), 
  .input_b(alu_input_b),
  .funct3(instr[14:12]),
  .funct7(instr[31:25]),
  .result(alu_result),
  .flags(alu_flags)
);

data_memory dm(
  .clk(clk),
  .addr(dm_addr),
  .data_input(dm_data_input),
  .write_en(d_mem_we),
  .data_output(dm_data_output)
);

// Multiplexer para o pc_next
assign pc_next = (pc_src==1'b1) ? pc_current + instr[31:25] : pc_current + 64'd1;

 // output to control unit
 assign opcode = instr[6:0];
endmodule