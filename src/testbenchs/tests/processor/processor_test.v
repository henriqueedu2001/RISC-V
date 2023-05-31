`timescale 1ps/1ps

module processor_test    #(
        parameter WORDSIZE = 64,           /* define o tamanho da palavra */
        parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
    ) (
    );

    wire [WORDSIZE-1:0] result;
    processor uut
 (
    .result(result)

    );
    initial begin
    #500;
    $monitor("result = %D\n\n", result);
    #500;
    $monitor("result = %D\n\n", result);
    #500;
    $monitor("result = %D\n\n", result);
    #500;
    $monitor("result = %D\n\n", result);
    end
endmodule