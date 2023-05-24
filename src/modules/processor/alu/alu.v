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
    
    /* saídas de cada módulo */
   
    // wire alu_flag_equal; /* saída de flag igualdade */
    // wire alu_flag_not_equal; /* saída de flag não igualdade */
    // wire alu_flag_greater; /* saída de flag maior */
    // wire alu_flag_less; /* saída de flag menor */
    // wire alu_flag_u_equal; /* saída de flag igualdade (sem sinal) */
    // wire alu_flag_u_greater; /* saída de flag maior (sem sinal) */
    // wire alu_flag_u_less; /* saída de flag menor (sem sinal) */

    wire [WORDSIZE-1:0] alu_int_ar_out; /* saída de INT_AR */
    wire [WORDSIZE-1:0] alu_flt_ar_out; /* saída de FLT_AR */
    wire [WORDSIZE-1:0] alu_bitwise_out; /* saída de BITWISE */
    wire [WORDSIZE-1:0] alu_bitshift_out; /* saída de BITSHIFT */

    /* saída final */
    wire [1:0] alu_unit_sel = operation[5:4];
    reg [WORDSIZE-1:0] alu_result;

    /* instanciação da INT_AR */
    alu_int_ar alu_int_ar_unit(
        .input_a(input_a),
        .input_b(input_b),
        .operation(operation),
        .out(alu_int_ar_out)
    );

    /* instanciação da FLT_AR */
    alu_flt_ar alu_flt_ar_unit(
        .input_a(input_a),
        .input_b(input_b),
        .operation(operation),
        .out(alu_int_ar_out)
    );

    /* instanciação da BITWISE */
    alu_bitwise alu_bitwise_unit(
        .input_a(input_a),
        .input_b(input_b),
        .operation(operation),
        .out(alu_int_ar_out)
    );

    /* instanciação da BITSHIFT */
    alu_bitshift alu_bitshift_unit(
        .input_a(input_a),
        .input_b(input_b),
        .operation(operation),
        .out(alu_int_ar_out)
    );

    /* instanciação da FLAGGER */
    flagger alu_flagger_unit(
        .input_a(input_a),
        .input_b(input_b),
        .flag_equal(flag_equal),
        .flag_not_equal(flag_not_equal),
        .flag_greater(flag_greater),
        .flag_less(flag_less),
        .flag_u_equal(flag_u_equal),
        .flag_u_greater(flag_u_greater),
        .flag_u_less(flag_u_less)
    );

    always @(*) begin
        case (alu_unit_sel)
            2'b00: alu_result = alu_int_ar_out;
            2'b01: alu_result = alu_flt_ar_out;
            2'b10: alu_result = alu_bitwise_out;
            2'b11: alu_result = alu_bitshift_out;
        endcase
    end

    assign result = alu_int_ar_out;

endmodule