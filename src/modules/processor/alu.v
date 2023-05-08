/* unidade lógico aritmética */
module alu #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [2:0] operation,         /* operação a ser realizada */
    output wire [WORDSIZE-1:0] result,  /* resultado */
    output wire flag_overflow,          /* sinal de detecção de overflow */
    output wire flag_equal,             /* flag */
    output wire flag_greater,           /*  */
    output wire flag_less,              /*  */
    output wire flag_uns_greater,       /*  */
    output wire flag_uns_less           /*  */
);

    /* operações da alu */
    localparam 
        alu_op_sum = 3'b000,     /* operação soma */
        alu_op_sub = 3'b001,     /* operação subtração */
        alu_op_equal = 3'b010,   /* verifica se a == b */
        alu_op_less = 3'b011,    /* verifica se a < b */
        alu_op_greater = 3'b100; /* verifica se a > b */

    /* somador-subtrator */
    wire [WORDSIZE-1:0] adder_sum;  /* soma obtida pelo somador */
    wire adder_overflow;            /* overflow somador */
    wire [WORDSIZE-1:0] neg_b;      /* vale oposto de b (neg_b = -input_b) */
    reg [WORDSIZE-1:0] b_value;

    always @(*) begin
        case (operation)
            alu_op_sum: b_value = input_b;
            alu_op_sub: b_value = neg_b;
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
        .overflow(adder_overflow)
    );

    assign result = adder_sum;
    assign overflow = adder_overflow;
    
endmodule