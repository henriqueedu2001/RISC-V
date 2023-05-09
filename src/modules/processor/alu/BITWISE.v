/* descrição */
module alu_bitwise #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [5:0] operation,         /* operação a ser realizada */
    output wire [WORDSIZE-1:0] out  /* outputs */
);

    localparam
        /* operações bitwise (BITWISE) */
        op_bitwise_and = 6'b10_0000, /* (BITWISE) a & b */
        op_bitwise_or =  6'b10_0001, /* (BITWISE) a | b */
        op_bitwise_not = 6'b10_0010, /* (BITWISE) ~a */
        op_bitwise_xor = 6'b10_0011; /* (BITWISE) a ^ b */

endmodule