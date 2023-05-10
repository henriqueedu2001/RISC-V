/* jumper */
module jumper #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) (
    input wire [WORDSIZE-1:0] immediate,           /* immediate */
    input wire [INSTRUCTION_SIZE-1:0] instruction,  /* instrução de 32 bits */
    input wire flag_equal,                         /* flag igualdade */
    input wire flag_not_equal,                     /* flag não igualdade */
    input wire flag_greater,                       /* flag maior */
    input wire flag_less,                          /* flag menor */
    input wire flag_u_equal,                       /* flag igualdade (sem sinal) */
    input wire flag_u_greater,                     /* flag maior (sem sinal) */
    input wire flag_u_less                         /* flag menor (sem sinal) */
);
    wire [2:0] funct3 = instruction[14:12];
    reg [WORDSIZE-1:0] inc;

    /* funct3 das instruções de branchs */
    localparam 
        funct3_beq =  3'b000,    /* beq */
        funct3_bne =  3'b001,    /* bne */
        funct3_blt =  3'b100,    /* blt */
        funct3_bge =  3'b101,    /* bge */
        funct3_bltu = 3'b110,    /* bltu */
        funct3_bgeu = 3'b111;    /* bgeu */

    localparam
        defalt_inc = 64'h0000_0000_0000_0001;

    always @(*) begin
        case (funct3)
            /* branch equal */
            funct3_beq: begin
                if(flag_equal == 1)
                    inc = immediate;
                else
                    inc = defalt_inc;
            end

            /* branch not equal */
            funct3_bne: begin
                if(flag_not_equal == 1)
                    inc = immediate;
                else
                    inc = defalt_inc;
            end

            /* branch less than */
            funct3_blt: begin
                if(flag_less == 1)
                    inc = immediate;
                else
                    inc = defalt_inc;
            end

            /* branch greater or equal */
            funct3_bge: begin
                if(flag_greater == 1 || flag_equal == 1)
                    inc = immediate;
                else
                    inc = defalt_inc;
            end

            /* branch less than unsigned */
            funct3_bltu: begin
                if(flag_u_less == 1)
                    inc = immediate;
                else
                    inc = defalt_inc;
            end

            /* branch greater */
            funct3_bgeu: begin
                if(flag_u_greater == 1)
                    inc = immediate;
                else
                    inc = defalt_inc;
            end

            /* default (nenhuma das instruções tipo branch) */
            default: 
                inc = defalt_inc;
        endcase
    end

endmodule