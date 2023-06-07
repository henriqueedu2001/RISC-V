/* descrição */
module alu_int_ar #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [9:0] operation,         /* operação a ser realizada */
    output wire [WORDSIZE-1:0] out,      /* outado */
    output wire overflow
);
        
    /* todas as operações da ALU */ 
    localparam
        /* operações aritméticas sobre inteiros (INT_AR) */
        op_int_ar_add = 10'b000_0000000, /* (INT_AR) a + b */
        op_int_ar_sub = 10'b000_0100000, /* (INT_AR) a - b */ 
        op_int_ar_neg = 6'b00_0010, /* (INT_AR) ~a */
        op_int_ar_inc = 6'b00_0011, /* (INT_AR) a + 1 */
        op_int_ar_dec = 6'b00_0100, /* (INT_AR) a - 1 */
        op_int_ar_and = 6'b00_0011, /* (INT_AR) a and b */
        op_int_ar_or = 6'b00_0100; /* (INT_AR) a or b */
    
    always @(*) begin
        case (operation)
            /* operação soma */
            op_int_ar_add: begin
                // $display("op_int_ar_add");
                result = input_a + input_b;
            end

            /* operação subtração */
            op_int_ar_sub: begin
                // $display("op_int_ar_sub");
                result = input_a - input_b;
            end

            /* operação oposto */
            op_int_ar_neg: begin
                result = 64'd1 + ~input_a;
            end

            /* operação incremento */
            op_int_ar_inc: begin
                result = input_a + 1;
            end

            /* operação decremento */
            op_int_ar_dec: begin
                result = input_a - 1;
            end

            /* operação AND */
            op_int_ar_and: begin 
                result = (input_a && input_b); 
            end

            /* operação OR */
            op_int_ar_or: begin 
                result = input_a || input_b; 
            end 

        endcase
    end

    reg [WORDSIZE-1:0] result;
    assign out = result;

endmodule