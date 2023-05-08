module greater #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  
    input wire [WORDSIZE-1:0] input_b,
    output reg greater                  /*  */
); 

    always@(*) begin
        if(input_a > input_b)
            greater <= 1'b1;   /* greater = 1 se a > b */
        else 
            greater <= 1'b0;   /* greater = 0 se a <= b */
    end
endmodule