`timescale 1ps/1ps

/* teste do módulo [...] */
module instruction_memory_test #(
    parameter WORDSIZE = 64,           /* tamanho da palavra (64) */
    parameter INSTRUCTION_SIZE = 32,   /* tamanho da instrução (32 para o RISC-V) */
    parameter MEMORY_SIZE = 1024       /* tamanho da memória (1024) */
) ();
    reg [WORDSIZE-1:0] addr;                   /* endereço da instrução */
    wire [INSTRUCTION_SIZE-1:0] instruction;   /* instrução correspondente */

    /* instanciação da unit under test */
    instruction_memory uut(
        .addr(addr),
        .instruction(instruction)
    );

    /* início do testbench */
    initial begin
        $monitor("--INSTRUCTION MEMORY TEST BEGIN--");
        #100;

        addr = 0;
        $monitor("addr = %H; instruction = %H", addr, instruction);
        #100;

        addr = 1;
        $monitor("addr = %H; instruction = %H", addr, instruction);
        #100;

        addr = 2;
        $monitor("addr = %H; instruction = %H", addr, instruction);
        #100;

        $monitor("--INSTRUCTION MEMORY TEST END--");
        #100;
    end
endmodule