/* somador completo de N bits */
module full_adder #(
    parameter N = 64
) (
    input wire [N-1:0] a,
    input wire [N-1:0] b,
    output wire [N-1:0] sum,
    output wire overflow
);
    genvar i;

    wire [N-1:0] carry_in;
    wire [N-1:0] carry_out;

    generate
        for(i = 0; i < N; i = i + 1) begin
            half_adder hf(
                .a(a[i]),
                .b(b[i]),
                .sum(sum[i]),
                .cin(carry_in[i]),
                .cout(carry_out[i])
            );
        end

        for(i = 0; i < N - 1; i = i + 1) begin
            assign carry_in[i+1] = carry_in[i];
        end

        assign carry_in[0] = 0;
        assign overflow = carry_out[N-1];
    endgenerate

endmodule //half_adder