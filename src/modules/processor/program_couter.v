/* program_counter (PC) */
module program_counter #(
    parameter WORDSIZE = 64           /* define o tamanho da palavra */
) (
    input wire clk,                   /* sinal de clock */
    output wire [WORDSIZE-1:0] addr   /* endereço da instrução atual */
);

    reg [WORDSIZE-1:0] current_addr; /* registrador para guardar endereço atual */
    reg [WORDSIZE-1:0] temp;         /* registrador temporário, para executar soma */

    /* valor do incremento (increment = 32) */
    reg [WORDSIZE-1:0] increment = 64'h0000_0000_0000_0001;

    /* inicializar registradores em zero */
    initial begin
        temp = 0;
        current_addr = 0;
    end

    /* ativação em borda de subida */
    always @(posedge clk) begin
        /* incremento em borda de subida */
        current_addr = temp + increment;
    end

    /* ativação em borda de descida */
    always @(negedge clk) begin
        /* cópia do endereço atual no registrador temporário */
        temp = current_addr;
    end

    /* endereço atual (addr) é lido do registrador current_addr */
    assign addr = current_addr;

endmodule