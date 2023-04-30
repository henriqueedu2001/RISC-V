`timescale 1ps/1ps

/* teste do data memory */
module data_memory_test #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter SIZE = 512               /* tamanho da memória */
) ();
    reg clk;                           /* sinal de clock */
    reg [WORDSIZE-1:0] addr;           /* endereço */
    reg [WORDSIZE-1:0] data_input;     /* valor de escrita */
    reg write_en;                      /* habilitação de escrita */
    wire [WORDSIZE-1:0] data_output;   /* valor de leitura */

    /* instanciação da unit under test */
    data_memory uut(
        .clk(clk),
        .addr(addr),
        .data_input(data_input),
        .write_en(write_en),
        .data_output(data_output)
    );

    /* início do testbench */
    initial begin
        clk = 0; addr = 3; write_en = 1;
        data_input = 54;
        $monitor("clk = %B; write_en = %B; addr = %H\ninput = %H\noutput = %H\n", 
            clk,
            write_en,
            addr,
            data_input,
            data_output
        );
        #100;

        clk = 1; addr = 3; write_en = 1;
        data_input = 54;
        $monitor("clk = %B; write_en = %B; addr = %H\ninput = %H\noutput = %H\n", 
            clk,
            write_en,
            addr,
            data_input,
            data_output
        );
        #100;

        clk = 0; addr = 3; write_en = 1;
        data_input = 54;
        $monitor("clk = %B; write_en = %B; addr = %H\ninput = %H\noutput = %H\n", 
            clk,
            write_en,
            addr,
            data_input,
            data_output
        );
        #100;

        clk = 0; addr = 3; write_en = 1;
        data_input = 13;
        $monitor("clk = %B; write_en = %B; addr = %H\ninput = %H\noutput = %H\n", 
            clk,
            write_en,
            addr,
            data_input,
            data_output
        );
        #100;

        clk = 1; addr = 5; write_en = 1;
        data_input = 13;
        $monitor("clk = %B; write_en = %B; addr = %H\ninput = %H\noutput = %H\n", 
            clk,
            write_en,
            addr,
            data_input,
            data_output
        );
        #100;

        clk = 0; addr = 0; write_en = 0;
        data_input = 13;
        $monitor("clk = %B; write_en = %B; addr = %H\ninput = %H\noutput = %H\n", 
            clk,
            write_en,
            addr,
            data_input,
            data_output
        );
        #100;

        clk = 0; addr = 3; write_en = 0;
        data_input = 13;
        $monitor("clk = %B; write_en = %B; addr = %H\ninput = %H\noutput = %H\n", 
            clk,
            write_en,
            addr,
            data_input,
            data_output
        );
        #100;

        clk = 0; addr = 5; write_en = 0;
        data_input = 54;
        $monitor("clk = %B; write_en = %B; addr = %H\ninput = %H\noutput = %H\n", 
            clk,
            write_en,
            addr,
            data_input,
            data_output
        );
        #100;
    end
endmodule