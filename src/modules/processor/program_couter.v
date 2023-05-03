/* program_counter (PC) */
module program_counter #(
    parameter WORDSIZE = 64           /* define o tamanho da palavra */
) (
    input wire clk,
    output wire [WORDSIZE-1:0] addr
);

    reg [WORDSIZE-1:0] current_addr;
    reg [WORDSIZE-1:0] temp;
    reg [WORDSIZE-1:0] increment = 64'h0000_0000_0000_0020;

    initial begin
        temp = 0;
        current_addr = 0;
    end

    always @(posedge clk) begin
        current_addr = temp + increment;
    end

    always @(negedge clk) begin
        temp = current_addr;
    end

    assign addr = current_addr;

endmodule