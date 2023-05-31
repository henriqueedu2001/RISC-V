module datapath #(
    parameter WORDSIZE = 64,           /* tamanho da palavra (64) */
    parameter INSTRUCTION_SIZE = 32   /* tamanho da instrução (32 para o RISC-V) */
)
(
 input finished,
 input clk,
 input rf_write_en,
 input dm_write_en,
 input wire fetch, 
 input wire decode,
 output[6:0] opcode,
 output[WORDSIZE-1:0] result
);

 reg  [WORDSIZE-1:0] pc_current;
 wire [WORDSIZE-1:0] pc_next;
 wire [INSTRUCTION_SIZE-1:0] instr;

 // Register File
 wire [4:0] rf_write_addr;
 wire [WORDSIZE-1:0] rf_write_data;
 wire [4:0] rf_addr_a;
 wire [WORDSIZE-1:0] rf_data_a;
 wire [4:0] rf_addr_b;
 wire [WORDSIZE-1:0] rf_data_b;

// Data Memory
 wire [WORDSIZE-1:0] dm_data_output;
 reg [4:0] dm_addr;

 wire [15:0] ext_im,read_data2;
 wire [2:0] ALU_Control;
 wire [15:0] ALU_out;
 wire zero_flag;
 wire [15:0] PC_j, PC_beq, PC_2beq,PC_2bne,PC_bne;
 wire beq_control;
 wire [12:0] jump_shift;

 // Flags 
 wire flag_overflow;          /* sinal de detecção de overflow */
 wire flag_equal;             /* flag igualdade */
 wire flag_not_equal;         /* flag não igualdade */
 wire flag_greater;           /* flag maior */
 wire flag_less;              /* flag menor */
 wire flag_u_equal;           /* flag igualdade (sem sinal) */
 wire flag_u_greater;         /* flag maior (sem sinal) */
 wire flag_u_less;            /* flag menor (sem sinal) */
 
 // PC 
 initial begin
  pc_current = 64'd0;
  dm_addr = 64'd0;
 end

// Atualizando o PC
 always @(finished)
 begin 
  case(finished)
   1'b0: $display("instr = %B", instr);
   1'b1: begin 
    pc_current <= pc_current + 64'd1;
   end
  endcase
   
 end

 // instruction memory
 instruction_memory im(.addr(pc_current),.instruction(instr));


//  // multiplexer regdest
//  assign rf_write_addr = (reg_dst==1'b1) ? instr[11:7] :instr[24:20];
 

 // register file
 assign rf_addr_a = instr[19:15];
 assign rf_addr_b = instr[24:20];
 assign rf_write_addr = instr[11:7];

 assign dm_data_input = rf_write_data;
 assign result = rf_write_data;
 
 // Instanciacao do Register File
 register_file reg_file
 (
  .clk(clk),
  .write_en(rf_write_en),
  .write_addr(rf_write_addr),
  .write_data(rf_write_data),
  .addr_a(rf_addr_a),
  .addr_b(rf_addr_b),
  .data_a(rf_data_a),
  .data_b(rf_data_b)
 );

// Instanciacao da ALU
alu alu_unit 
(
  .input_a(rf_data_a), 
  .input_b(rf_data_b),
  .funct3(instr[14:12]),
  .funct7(instr[31:25]),
  .result(rf_write_data),
  .flag_overflow(flag_overflow),
  .flag_equal(flag_equal),
  .flag_not_equal(flag_not_equal),
  .flag_greater(flag_greater),
  .flag_less(flag_less),
  .flag_u_equal(flag_u_equal),
  .flag_u_greater(flag_u_greater),
  .flag_u_less(flag_u_less)
);

//  // immediate extend
//  assign ext_im = {{10{instr[5]}},instr[5:0]};  
//  // ALU control unit
//  // multiplexer alu_src
//  assign read_data2 = (alu_src==1'b1) ? ext_im : rf_data_b;
//  // ALU 
//  // PC beq add
//  assign PC_beq = pc2 + {ext_im[14:0],1'b0};
//  assign PC_bne = pc2 + {ext_im[14:0],1'b0};
//  // beq control
//  assign beq_control = beq & zero_flag;
//  assign bne_control = bne & (~zero_flag);
//  // PC_beq
//  assign PC_2beq = (beq_control==1'b1) ? PC_beq : pc2;
//  // PC_bne
//  assign PC_2bne = (bne_control==1'b1) ? PC_bne : PC_2beq;
//  // PC_j
//  assign PC_j = {pc2[15:13],jump_shift};
//  // PC_next
//  assign pc_next = (jump == 1'b1) ? PC_j :  PC_2bne;

 /// Data memory
//   Data_Memory dm
//    (
//     .clk(clk),
//     .mem_access_addr(ALU_out),
//     .dm_write_en_data(rf_data_b),
//     .dm_write_en_en(dm_write_en),
//     .mem_read(mem_read),
//     .mem_read_data(mem_read_data)
//    );
 
 data_memory dm(
    .clk(clk),
    .addr(dm_addr),
    .data_input(dm_data_input),
    .write_en(dm_write_en),
    .data_output(dm_data_output)
);

//  // write back
//  assign rf_write_data = (mem_to_reg == 1'b1)?  mem_read_data: ALU_out;
 
 // output to control unit
 assign opcode = instr[6:0];
endmodule