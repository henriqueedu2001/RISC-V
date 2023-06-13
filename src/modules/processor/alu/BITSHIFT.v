/* descrição */
module alu_bitshift #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [5:0] operation,         /* operação a ser realizada */
    output wire [WORDSIZE-1:0] out  /* outputs */
);

    localparam
        /* operações bitshift (BITSHIFT) */
        op_bitshift_ar_right_shift = 6'b11_0000, /* (BITSHIFT) a >> b (aritmético) */
        op_bitshift_ar_left_shift = 6'b11_0001, /* (BITSHIFT) a << b (aritmético) */
        op_bitshift_l_right_shift = 6'b11_0010, /* (BITSHIFT) a >> b (lógico) */
        op_bitshift_l_left_shift = 6'b11_0011; /* (BITSHIFT) a << b (lógico) */

endmodule