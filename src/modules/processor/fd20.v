/* GRUPO 20
BÁRBARA FERNANDES DIAS BUENO 
JULIANA MITIE HOSNE NAKATA 
*/


/* ---------------------- FLUXO DE DADOS ----------------------*/

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

assign i_mem_addr = pc_current;
assign instr = i_mem_data;

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

assign d_mem_addr = dm_addr;
assign dm_data_output = d_mem_data;

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
   
 // Register file
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

// Multiplexador para o alu_input_b
assign alu_input_b = (alu_src==1'b1) ? instr[31:20] : rf_data_b;

 assign opcode = instr[6:0];

wire [2:0] funct3;
assign funct3 = instr[14:12];

wire [6:0] funct7;

// Se for BEQ, realizar subtração
assign funct7 = (opcode == 7'b1100011) ? 7'b0100000 : instr[31:25];

// Instanciacao da ALU
alu alu_unit 
(
  .input_a(rf_data_a), 
  .input_b(alu_input_b),
  .funct3(funct3),
  .funct7(funct7),
  .result(alu_result),
  .flags(alu_flags)
);

// Multiplexador para o pc_next
assign pc_next = (pc_src == 1'b1 && alu_flags[0] == 1'b1) ? pc_current + {instr[31:25], instr[11:7]} : pc_current + 64'd1;

endmodule

/* ---------------------- ONE - BIT REGISTER ----------------------*/

module one_bit_register #(parameter N = 64) (
    input wire clk,        /* sinal de clock */
    input wire load,       /* sinal de load */
    input wire reset,      /* sinal de reset */
    input wire data_in,    /* dado para escrita */
    output wire data_out   /* dado de leitura */
);
    /* latch que armazena o valor */
    reg data;
    
    /* iniciar registrador zerado */
    initial begin
        data = 0;
    end

    /* ativação em borda de subida do clock */
    always @(posedge clk) begin
        /* escrever data_in se load = 1 */
        if(load)
            data = data_in;
        
        /* zerar registrador se reset = 1 */
        if(reset)
            data = 0;
    end

    /* data_out recebe valor de saída do latch */
    assign data_out = data;

endmodule

/* ---------------------- N - BIT REGISTER ----------------------*/

module n_bits_register #(
    parameter WORDSIZE = 64              /* define tamanho da palavra */
) (
    input wire clk,                      /* sinal de clock */
    input wire load,                     /* sinal de load */ 
    input wire reset,                    /* sinal de reset */
    input wire [WORDSIZE-1:0] data_in,   /* palavra a ser escrita */
    output wire [WORDSIZE-1:0] data_out  /* palavra a ser lida */
);
    /* instanciação de N = WORDSIZE registradores */
    genvar i;
    generate
        for(i = 0; i < WORDSIZE; i = i + 1) begin     
            one_bit_register sg(
                .clk(clk),
                .load(load),
                .reset(reset),
                .data_in(data_in[i]),
                .data_out(data_out[i])
            );
        end
    endgenerate
endmodule

/* ---------------------- REGISTER FILE ----------------------*/

module register_file #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter SIZE = 32                /* quantidade de registradores */
) (
    input wire clk,                          /* sinal de clock */
    input wire write_en,                     /* habilita escrita */
    input wire [4:0] write_addr,             /* endereço para escrita */
    input wire [WORDSIZE-1:0] write_data,    /* valor a ser escrito */
    input wire [4:0] addr_a,                 /* endereço do registrador A a ser lido */
    input wire [4:0] addr_b,                 /* endereço do registrador B a ser lido */
    output wire [WORDSIZE-1:0] data_a,       /* valor lido pelo registrador A */
    output wire [WORDSIZE-1:0] data_b        /* valor lido pelo registrador B */
);

    /* sinais de load para cada registrador */
    wire [SIZE-1:0] registers_load;

    /* saídas de 64 bits de cada registrador */           
    wire [SIZE-1:0] [WORDSIZE-1:0] registers_data_out;

    /* gera um banco de 32 registradores de 64 bits */
    genvar i;
    generate
        for (i = 0; i < SIZE; i = i + 1) begin: REG_INST
            n_bits_register n_bits_reg (
                .clk(clk),
                .load(registers_load[i]),
                .reset(),
                .data_in(write_data),
                .data_out(registers_data_out[i])
            );
        end
    endgenerate

    /* coloca o sinal de load nos registradores corretos */
    generate
        for (i = 0; i < SIZE; i = i + 1) begin
            assign registers_load[i] = (write_en) & (write_addr == i);
        end
    endgenerate

    /* leitura dos registradores A e B */
    reg [WORDSIZE-1:0] a; /* valor de saída do registrador a */
    reg [WORDSIZE-1:0] b; /* valor de saída do registrador b */

    /* TODO tornar remover o always e usar apenas assign */

    /* ativação em qualquer instante */
    always @ (*) begin
        /* leitura assíncrona com o clock */
        a <= registers_data_out[addr_a]; 
        b <= registers_data_out[addr_b];
    end

    /* valores lidos em A e em B */
    assign data_a = a;
    assign data_b = b;

endmodule

/* ---------------------- ALU SOMA DE INT ----------------------*/

module alu_int_ar #(
    parameter WORDSIZE = 64             /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [9:0] operation,         /* operação a ser realizada */
    output wire [WORDSIZE-1:0] out,     /* outado */
    output wire overflow
);
        
    /* todas as operações da ALU */ 
    localparam
        /* operações aritméticas sobre inteiros (INT_AR) */
        op_int_ar_add = 10'b000_0000000,    /* (INT_AR) a + b */
        op_int_ar_sub = 10'b000_0100000,    /* (INT_AR) a - b */ 
        op_int_ar_neg = 6'b00_0010,         /* (INT_AR) ~a */
        op_int_ar_inc = 6'b00_0011,         /* (INT_AR) a + 1 */
        op_int_ar_dec = 6'b00_0100,         /* (INT_AR) a - 1 */
        op_int_ar_and = 6'b00_0011,         /* (INT_AR) a and b */
        op_int_ar_or = 6'b00_0100;          /* (INT_AR) a or b */
    
    always @(*) begin
        case (operation)
            /* operação soma */
            op_int_ar_add: begin
                result = input_a + input_b;
            end

            /* operação subtração */
            op_int_ar_sub: begin
                result = input_a - input_b;
            end

            /* operação oposto */
            op_int_ar_neg: begin
                result = 64'd1 + ~input_a;
            end

            /* operação incremento */
            op_int_ar_inc: begin
                result = input_a + 1;
            end

            /* operação decremento */
            op_int_ar_dec: begin
                result = input_a - 1;
            end

            /* operação AND */
            op_int_ar_and: begin 
                result = (input_a && input_b); 
            end

            /* operação OR */
            op_int_ar_or: begin 
                result = input_a || input_b; 
            end 

        endcase
    end

    reg [WORDSIZE-1:0] result;
    assign out = result;

endmodule

/* ---------------------- FLAGGER ----------------------*/

module flagger_padronizado #(
    parameter WORDSIZE = 64             /* define o tamanho da palavra */
) ( 
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [WORDSIZE-1:0] result,   /* resultado */
    input wire funct7,                  /* operacao sendo realizada */
    output wire [3:0] flags             /* flags */
); 

    /* registradores para cada flag */
    reg alu_p_flag_zero;
    reg alu_p_flag_msb; 
    reg alu_p_flag_overflow; 
    reg alu_p_flag_extra; 

    /* conexao dos fios de saida */
    assign flags = {alu_p_flag_extra, alu_p_flag_overflow, alu_p_flag_msb, alu_p_flag_zero}; 

    always @(*) begin 
        /* flag para zero */
        assign alu_p_flag_zero = (result == 1'b0) ? 1'b1 : 1'b0;
        /* flag para msb */
        assign alu_p_flag_msb = result[63]; 
        
        /* flag para casos de overflow com complemento 2 */
        if(input_a[63] == 0 && input_b[63] == 0 && result[63] == 1 && funct7 == 0) alu_p_flag_overflow <= 1'b1; 
        else if (input_a[63] == 1 && input_b[63] == 1 && result[63] == 0 && funct7 == 0) alu_p_flag_overflow <= 1'b1; 
        else if (input_a[63] == 1 && input_b[63] == 0 && result[63] == 1) alu_p_flag_overflow <= 1'b1; 
        else if (input_a[63] == 1 && input_b[63] == 1 && result[63] == 0) alu_p_flag_overflow <= 1'b1; 
        else alu_p_flag_overflow <= 1'b0;

        /* flag extra */
        assign alu_p_flag_extra = 1'b1;
    end  

endmodule 

/* ---------------------- ALU ----------------------*/

// modulo unidade lógico aritmética (ALU)
module alu #(
    parameter WORDSIZE = 64             /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [3:0] alu_cmd,
    input wire [2:0] funct3,            /* operação funct3 a ser realizada */
    input wire [6:0] funct7,            /* operação funct7 a ser realizada */
    output wire [WORDSIZE-1:0] result,  /* resultado */
    output wire [3:0] flags             /* vetor com as 4 flags */
);

    wire alu_unit_sel = 2'b00;
    /* todas as operações da ALU */
    localparam
        /* operações aritméticas sobre inteiros (INT_AR) */
        op_int_ar_add = 6'b00_0000, /* (INT_AR) a + b */
        op_int_ar_sub = 6'b00_0001, /* (INT_AR) a - b */
        op_int_ar_neg = 6'b00_0010, /* (INT_AR) ~a */
        op_int_ar_inc = 6'b00_0011, /* (INT_AR) a + 1 */
        op_int_ar_dec = 6'b00_0100, /* (INT_AR) a - 1 */

        /* operações aritméticas sobre ponto flutuante (FLT_AR) */
        op_flt_ar_add = 6'b01_0000, /* (FLT_AR) a + b */
        op_flt_ar_sub = 6'b01_0001, /* (FLT_AR) a - b */
        op_flt_ar_neg = 6'b01_0010, /* (FLT_AR) ~a */

        /* operações bitwise (BITWISE) */
        op_bitwise_and = 6'b10_0000, /* (BITWISE) a & b */
        op_bitwise_or =  6'b10_0001, /* (BITWISE) a | b */
        op_bitwise_not = 6'b10_0010, /* (BITWISE) ~a */
        op_bitwise_xor = 6'b10_0011, /* (BITWISE) a ^ b */

        /* operações bitshift (BITSHIFT) */
        op_bitshift_ar_right_shift = 6'b11_0000, /* (BITSHIFT) a >> b (aritmético) */
        op_bitshift_ar_left_shift = 6'b11_0001,  /* (BITSHIFT) a << b (aritmético) */
        op_bitshift_l_right_shift = 6'b11_0010,  /* (BITSHIFT) a >> b (lógico) */
        op_bitshift_l_left_shift = 6'b11_0011;   /* (BITSHIFT) a << b (lógico) */

    wire [WORDSIZE-1:0] alu_int_ar_out;   /* saída de INT_AR */
    wire [WORDSIZE-1:0] alu_flt_ar_out;   /* saída de FLT_AR */
    wire [WORDSIZE-1:0] alu_bitwise_out;  /* saída de BITWISE */
    wire [WORDSIZE-1:0] alu_bitshift_out; /* saída de BITSHIFT */

    /* saída final */
    reg [WORDSIZE-1:0] alu_result;

    /* instanciação da INT_AR */
    alu_int_ar alu_int_ar_unit(
        .input_a(input_a),
        .input_b(input_b),
        .operation({funct3,funct7}),
        .out(alu_int_ar_out) // resultado da operação
    );

    /* instanciação da FLAGGER_PADRONIZADO */
    flagger_padronizado flagger_padronizado_unit(
        .input_a(input_a),
        .input_b(input_b), 
        .result(alu_int_ar_out), 
        .funct7(funct7), 
        .flags(flags)
    );

    always @(*) begin
        case (alu_unit_sel)
            
            2'b00: begin
                alu_result = alu_int_ar_out;
                $display("alu_result: %b", alu_int_ar_out);
            end
            2'b01: alu_result = alu_flt_ar_out;
            2'b10: alu_result = alu_bitwise_out;
            2'b11: alu_result = alu_bitshift_out;
        endcase
    end

    assign result = alu_result;
endmodule
