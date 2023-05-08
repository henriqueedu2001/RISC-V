module less #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  
    input wire [WORDSIZE-1:0] input_b,
    output reg less
); 

    always@(*) begin
        if(input_a < input_b)
            less <= 1'b1;
        else 
            less <= 1'b0;    
    end
endmodule