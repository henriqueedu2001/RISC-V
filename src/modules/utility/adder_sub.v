/* unidade lógico aritmética */
module adder_sub #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire operation,               /* operação a ser realizada */
    output wire [WORDSIZE-1:0] result,  /* resultado */
    output overflow
);

    /* somador-subtrator */
    wire [WORDSIZE-1:0] adder_sum;  /* soma obtida pelo somador */
    wire adder_overflow;            /* overflow somador */
    wire [WORDSIZE-1:0] neg_b;      /* vale oposto de b (neg_b = -input_b) */
    reg [WORDSIZE-1:0] b_value;

    always @(*) begin
        case (operation)
            0: b_value = input_b;
            1: b_value = neg_b;
        endcase
    end

    opposite opp(
        .num_input(input_b),
        .num_output(neg_b)
    );

    full_adder adder(
        .a(input_a),
        .b(b_value),
        .sum(adder_sum),
        .overflow(overflow)
    );

    assign result = adder_sum;
    assign overflow = overflow;
    
endmodule