/* multiplexador que escolhe entre dois números de 64 bits */
module general_mux #(
    parameter WORDSIZE = 64
) (
    input wire [WORDSIZE-1:0] input_a,  /* input a */
    input wire [WORDSIZE-1:0] input_b,  /* input b */
    input wire sel,                     /* seletor */
    output wire [WORDSIZE-1:0] out      /* output */
);
    reg [WORDSIZE-1:0] selected_input;

    always @(*) begin
        if(sel == 0) 
            selected_input = input_a;
        else
            selected_input = input_b;
    end

    assign out = selected_input;
endmodule