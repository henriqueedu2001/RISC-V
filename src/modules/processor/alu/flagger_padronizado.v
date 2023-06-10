module flagger_padronizado #(
    parameter WORDSIZE = 64             /* define o tamanho da palavra */
) ( 
    input wire [WORDSIZE-1:0] input_a,  /* primeiro valor da operação */  
    input wire [WORDSIZE-1:0] input_b,  /* segundo valor da operação */
    input wire [WORDSIZE-1:0] result,  /* resultado */
    input wire funct7, /* operacao sendo realizada */
    output wire [3:0] flags
); 

    /* registradores para cada flag */
    reg alu_p_flag_zero;
    reg alu_p_flag_msb; 
    reg alu_p_flag_overflow; 
    reg alu_p_flag_extra; 

    /* conexao dos fios de saida */
    assign flags = {alu_p_flag_extra, alu_p_flag_overflow, alu_p_flag_msb, alu_p_flag_zero}; 

    always @(*) begin 
        /* flag para zero */
        assign alu_p_flag_zero = (result == 1'b0) ? 1'b1 : 1'b0;
        /* flag para msb */
        assign alu_p_flag_msb = result[63]; 
        
        /* flag para casos de overflow com complemento 2 */
        if(input_a[63] == 0 && input_b[63] == 0 && result[63] == 1 && funct7 == 0) alu_p_flag_overflow <= 1'b1; 
        else if (input_a[63] == 1 && input_b[63] == 1 && result[63] == 0 && funct7 == 0) alu_p_flag_overflow <= 1'b1; 
        else if (input_a[63] == 1 && input_b[63] == 0 && result[63] == 1) alu_p_flag_overflow <= 1'b1; 
        else if (input_a[63] == 1 && input_b[63] == 1 && result[63] == 0) alu_p_flag_overflow <= 1'b1; 
        else alu_p_flag_overflow <= 1'b0;

        /* flag extra */
        assign alu_p_flag_extra = 1'b1;
    end  

endmodule 
