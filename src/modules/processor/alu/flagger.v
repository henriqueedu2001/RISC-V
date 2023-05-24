/* unidade lógico aritmética */
module flagger #(
    parameter WORDSIZE = 64             /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
//  output wire flag_overflow,          /* sinal de detecção de overflow */
    output wire flag_equal,             /* flag igualdade */
    output wire flag_not_equal,         /* flag não igualdade */
    output wire flag_greater,           /* flag maior */
    output wire flag_less,              /* flag menor */
    output wire flag_u_equal,           /* flag igualdade (sem sinal) */
    output wire flag_u_greater,         /* flag maior (sem sinal) */
    output wire flag_u_less             /* flag menor (sem sinal) */
);

    /* registradores para cada flag */
    reg alu_flag_equal;                 /* flag igualdade */
    reg alu_flag_not_equal;             /* flag não igualdade */
    reg alu_flag_greater;               /* flag maior */
    reg alu_flag_less;                  /* flag menor */
    reg alu_flag_u_equal;               /* flag igualdade (sem sinal) */
    reg alu_flag_u_greater;             /* flag maior (sem sinal) */
    reg alu_flag_u_less;                /* flag menor (sem sinal) */

    /* conexão dos fios de saída */
    assign flag_equal = alu_flag_equal;
    assign flag_not_equal = alu_flag_not_equal;
    assign flag_greater = alu_flag_greater;
    assign flag_less = alu_flag_less;
    assign flag_u_equal = alu_flag_u_equal;
    assign flag_u_greater = alu_flag_u_greater;
    assign flag_u_less = alu_flag_u_less;

    /* verifica igualdade */
    always @(*) begin
        if(input_a == input_b) begin
            alu_flag_equal = 1;
            alu_flag_not_equal = 0;
            alu_flag_u_equal = 1;
        end else begin
            alu_flag_equal = 0;
            alu_flag_not_equal = 1;
        end
    end

    /* verifica se a > b unsigned */
    always @(*) begin
        if(input_a > input_b) begin
            alu_flag_u_greater = 1;
            alu_flag_u_less = 0;
        end else begin
            alu_flag_u_greater = 0;
        end
    end

    /* verifica se a < b unsigned */
    always @(*) begin
        if(input_a < input_b) begin
            alu_flag_u_greater = 0;
            alu_flag_u_less = 1;
        end else begin
            alu_flag_u_less = 0;
        end
    end

    /* verifica as desigualdades com complemento de dois */
    always @(*) begin
        if(input_a[WORDSIZE-1] == 1 && input_b[WORDSIZE-1] == 1) begin
            alu_flag_greater = ~ alu_flag_u_greater;
            alu_flag_less = ~alu_flag_u_less;
        end
        else if(input_a[WORDSIZE-1] == 1) begin
            alu_flag_greater = 0;
            alu_flag_less = 1;
        end
        else if(input_b[WORDSIZE-1] == 1) begin
            alu_flag_greater = 1;
            alu_flag_less = 0;
        end
        else begin
            alu_flag_greater = alu_flag_u_greater;
            alu_flag_less = alu_flag_u_less;
        end
    end


endmodule