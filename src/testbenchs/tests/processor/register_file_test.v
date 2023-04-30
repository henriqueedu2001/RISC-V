`timescale 1ps/1ps

/* teste do register file */
module register_file_test #(
    parameter WORDSIZE = 64           /* define o tamanho da palavra */
) ();
    reg clk;                          /* sinal de clock */
    reg write_en;                     /* habilita escrita */
    reg [4:0] write_addr;             /* endereço para escrita */
    reg [WORDSIZE-1:0] write_data;    /* valor a ser escrito */
    reg [4:0] addr_a;                 /* endereço do registrador A a ser lido */
    reg [4:0] addr_b;                 /* endereço do registrador B a ser lido */
    wire [WORDSIZE-1:0] data_a;       /* valor lido pelo registrador A */
    wire [WORDSIZE-1:0] data_b;       /* valor lido pelo registrador B */

    /* instanciação da unit under test */
    register_file uut(
        .clk(clk),
        .write_en(write_en),
        .write_addr(write_addr),
        .write_data(write_data),
        .addr_a(addr_a),
        .addr_b(addr_b),
        .data_a(data_a),
        .data_b(data_b)
    );

    /* início do testbench */
    initial begin
        clk = 0; write_en = 0;
        write_addr = 0;
        write_data = 0;
        addr_a = 0;
        addr_b = 0;
        $monitor("%H\n%H\n", data_a, data_b);
        #100;
    end
endmodule