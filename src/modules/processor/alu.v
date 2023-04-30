/* unidade lógico aritmética */
module alu #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [2:0] operation,         /* operação a ser realizada */
    output wire [WORDSIZE-1:0] result,   /* resultado */
    output wire overflow                /* sinal de detecção de overflow */
);

    /* somador */
    wire [WORDSIZE-1:0] adder_sum;  /* soma obtida pelo somador */
    wire adder_overflow;            /* overflow somador */

    full_adder adder(
        .a(input_a),
        .b(input_b),
        .sum(adder_sum),
        .overflow(adder_overflow)
    );

    assign result = adder_sum;
    assign overflow = adder_overflow;
    
endmodule