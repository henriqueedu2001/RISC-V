module equal #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
) (
    input wire [WORDSIZE-1:0] input_a,  
    input wire [WORDSIZE-1:0] input_b,
    output reg equal
); 

    always@(*) begin
        if(input_a == input_b)
            equal <= 1'b1;
        else 
            equal <= 1'b0;    
    end
endmodule