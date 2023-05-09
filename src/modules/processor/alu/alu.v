/* unidade lógico aritmética */
module alu #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [5:0] operation,         /* operação a ser realizada */
    output wire [WORDSIZE-1:0] result,  /* resultado */
    output wire flag_overflow,          /* sinal de detecção de overflow */
    output wire flag_equal,             /* flag igualdade */
    output wire flag_not_equal,         /* flag não igualdade */
    output wire flag_greater,           /* flag maior */
    output wire flag_less,              /* flag menor */
    output wire flag_u_equal,           /* flag igualdade (sem sinal) */
    output wire flag_u_greater,         /* flag maior (sem sinal) */
    output wire flag_u_less             /* flag menor (sem sinal) */
);

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
        op_bitshift_ar_left_shift = 6'b11_0001, /* (BITSHIFT) a << b (aritmético) */
        op_bitshift_l_right_shift = 6'b11_0010, /* (BITSHIFT) a >> b (lógico) */
        op_bitshift_l_left_shift = 6'b11_0011; /* (BITSHIFT) a << b (lógico) */
    
    

endmodule