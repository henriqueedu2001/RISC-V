/* calcula o valor absoluto */
module absolute_value #(parameter N = 64) (
    input wire signed [N-1:0] number, /* numero x, cujo módulo se deseja calcular */
    output reg signed [N-1:0] abs /* módulo do número x */
);
    wire signed [N-1:0] opposite; /* armazena o valor do negativo de x (opposite = -x) */
    
    /* cálculo do valor absoluto pela definição de módulo */
    always @(number) begin
        if(number > 0) begin
            abs <= number; /* |x| = x, para x >= 0 */
        end
        else begin
            abs <= ~number + 1; /* |x| = -x, para x < 0 */
        end
        
    end

endmodule