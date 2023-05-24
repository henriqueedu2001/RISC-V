module Datapath_Unit #(
    parameter WORDSIZE = 64,           /* tamanho da palavra (64) */
    parameter INSTRUCTION_SIZE = 32,   /* tamanho da instrução (32 para o RISC-V) */
)(
 input clk,
 input jump,beq,dm_write_en,alu_src,reg_dst,mem_to_reg,rf_write_en,bne,
 input[1:0] alu_op,
 output[3:0] opcode
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

// Data Memorty
 wire [WORDSIZE-1:0] dm_data_output;

 wire [15:0] ext_im,read_data2;
 wire [2:0] ALU_Control;
 wire [15:0] ALU_out;
 wire zero_flag;
 wire [15:0] PC_j, PC_beq, PC_2beq,PC_2bne,PC_bne;
 wire beq_control;
 wire [12:0] jump_shift;
 

 // PC 
 initial begin
  pc_current <= 16'd0;
 end

// Atualizando o PC
 always @(posedge clk)
 begin 
   pc_current <= pc_next;
 end

 // instruction memory
 instruction_memory im(.pc(pc_current),.instruction(instr));


 // multiplexer regdest
 assign rf_write_addr = (reg_dst==1'b1) ? instr[11:7] :instr[24:20];
 
 // register file
 assign rf_addr_a = instr[19:15];
 assign rf_addr_b = instr[24:20];

 // GENERAL PURPOSE REGISTERs
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


 // immediate extend
 assign ext_im = {{10{instr[5]}},instr[5:0]};  
 // ALU control unit
 alu_control ALU_Control_unit(.ALUOp(alu_op),.Opcode(instr[15:12]),.ALU_Cnt(ALU_Control));
 // multiplexer alu_src
 assign read_data2 = (alu_src==1'b1) ? ext_im : rf_data_b;
 // ALU 
 ALU alu_unit(.a(rf_data_a),.b(read_data2),.alu_control(ALU_Control),.result(ALU_out),.zero(zero_flag));
 // PC beq add
 assign PC_beq = pc2 + {ext_im[14:0],1'b0};
 assign PC_bne = pc2 + {ext_im[14:0],1'b0};
 // beq control
 assign beq_control = beq & zero_flag;
 assign bne_control = bne & (~zero_flag);
 // PC_beq
 assign PC_2beq = (beq_control==1'b1) ? PC_beq : pc2;
 // PC_bne
 assign PC_2bne = (bne_control==1'b1) ? PC_bne : PC_2beq;
 // PC_j
 assign PC_j = {pc2[15:13],jump_shift};
 // PC_next
 assign pc_next = (jump == 1'b1) ? PC_j :  PC_2bne;

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

 // write back
 assign rf_write_data = (mem_to_reg == 1'b1)?  mem_read_data: ALU_out;
 
 // output to control unit
 assign opcode = instr[6:0];
endmodule