module uc (
    input clk, rst_n,                       // clock borda subida, reset assíncrono ativo baixo
    input [5:0] opcode,                     // OpCode direto do IR no FD
    output d_mem_we, rf_we,                 // Habilita escrita na memória de dados e no banco de registradores
    input  [3:0] alu_flags,                 // Flags da ULA
    output [3:0] alu_cmd,                   // Operação da ULA
    output alu_src, pc_src, rf_src          // Seletor dos MUXes
);  
endmodule

module fd 
    #(  // Tamanho em bits dos barramentos
        parameter i_addr_bits = 6,
        parameter d_addr_bits = 6
    )(
        input  clk, rst_n,                   // clock borda subida, reset assíncrono ativo baixo
        output [5:0] opcode,                    
        input  d_mem_we, rf_we,              // Habilita escrita na memória de dados e no banco de registradores
        input  [3:0] alu_cmd,                // ver abaixo
        output [3:0] alu_flags,
        input  alu_src,                      // 0: rf, 1: imm
               pc_src,                       // 0: +4, 1: +imm
               rf_src,                       // 0: alu, 1:d_mem
        output [i_addr_bits-1:0] i_mem_addr,
        input  [31:0]            i_mem_data,
        output [d_addr_bits-1:0] d_mem_addr,
        inout  [63:0]            d_mem_data

    );
    // AluCmd      AluFlags
    // 0000: and   0: zero
    // 0001: or    1: MSB 
    // 0010: add   2: overflow
    // 0110: sub             
endmodule


module polirv 
    #(
        parameter i_addr_bits = 6,
        parameter d_addr_bits = 6
    ) (
        input clk, rst_n,                       // clock borda subida, reset assíncrono ativo baixo
        output [i_addr_bits-1:0] i_mem_addr,
        input  [31:0]            i_mem_data,
        output                   d_mem_we,
        output [d_addr_bits-1:0] d_mem_addr,
        inout  [63:0]            d_mem_data
    );
endmodule
