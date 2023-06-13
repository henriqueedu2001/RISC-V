/* descrição */
module alu_flt_ar #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [5:0] operation,         /* operação a ser realizada */
    output wire [WORDSIZE-1:0] out  /* outputs */
);
    localparam
        /* operações aritméticas sobre ponto flutuante (FLT_AR) */
        op_flt_ar_add = 6'b01_0000, /* (FLT_AR) a + b */
        op_flt_ar_sub = 6'b01_0001, /* (FLT_AR) a - b */
        op_flt_ar_neg = 6'b01_0010; /* (FLT_AR) ~a */

endmodule