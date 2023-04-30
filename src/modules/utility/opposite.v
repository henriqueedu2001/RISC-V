/* recebe um número de 64 bits e devolve o oposto, em complemento de 2 */
module opposite #(
    parameter WORDSIZE = 64
) (
    input wire signed [WORDSIZE-1:0] num_input,   /* número de entrada (in) */
    output wire signed [WORDSIZE-1:0] num_output  /* número de saída (out = ~in + 1) */
);  

    /* inversão dos bits de num_input */
    wire [WORDSIZE-1:0] not_num_input;
    assign not_num_input = ~num_input;

    /* soma de uma unidade */
    wire [WORDSIZE-1:0] one_const;
    assign one_const = 64'h0000_0000_0000_0001;

    /* propriedades */
    full_adder adder(
        .a(not_num_input),
        .b(one_const),
        .sum(num_output),
        .overflow()
    );

endmodule