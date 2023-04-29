/* somador completo de N bits */
module full_adder #(
    parameter N = 64
) (
    input wire [N-1:0] a,     /* primeira número da soma */
    input wire [N-1:0] b,     /* segundo número da soma */
    output wire [N-1:0] sum,  /* resultado da soma */
    output wire overflow      /* 1 se houve overflow e 0 se não houve */
);
    /* fios do carry in e do carry out */
    wire [N-1:0] carry_in;
    wire [N-1:0] carry_out;

    
    genvar i;
    generate
        /* instanciação de 64 somadores de 1 bit */
        for(i = 0; i < N; i = i + 1) begin
            half_adder hf(
                .a(a[i]),
                .b(b[i]),
                .sum(sum[i]),
                .cin(carry_in[i]),
                .cout(carry_out[i])
            );
        end

        /* conexão em cadeia do carry in de um no carry out do seguinte */
        for(i = 0; i < N - 1; i = i + 1)
            assign carry_in[i+1] = carry_out[i];
        
        /* carry in do primeiro dígito é sempre nulo */
        assign carry_in[0] = 0;

        /* carry out do último dígito indica overflow */
        assign overflow = carry_out[N-1];
    endgenerate

endmodule