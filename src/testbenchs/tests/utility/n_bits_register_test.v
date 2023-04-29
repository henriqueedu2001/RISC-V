`timescale 1ps/1ps

/* teste do módulo [...] */
module one_bit_register_test #(parameter WORDSIZE = 64) ();
    reg clk;                       /* sinal de clock */
    reg load;                      /* sinal de load */
    reg reset;                     /* sinal de reset */
    reg [WORDSIZE-1:0] data_in;    /* dado a ser escrito */
    wire [WORDSIZE-1:0] data_out;  /* dado de leitura */
    
    /* instanciação da unit under test */
    n_bits_register uut(
        .clk(clk),
        .load(load),
        .reset(reset),
        .data_in(data_in),
        .data_out(data_out)
    );

    localparam n0 = 64'h0000_0000_0000_0000, /* primeiro número para teste */
               n1 = 64'h14a7_e226_fc32_92a1, /* segundo número para teste */
               n2 = 64'hffff_ffff_ffff_ffff; /* terceiro número para teste */

    /* início do testbench */
    initial begin
        clk = 0;
        load = 1; reset = 0; data_in = n0;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %H\ndata_out = %H\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 1;
        load = 1; reset = 0; data_in = n0;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %H\ndata_out = %H\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 0;
        load = 1; reset = 0; data_in = n1;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %H\ndata_out = %H\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 1;
        load = 1; reset = 0; data_in = n1;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %H\ndata_out = %H\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 0;
        load = 0; reset = 0; data_in = n2;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %H\ndata_out = %H\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 1;
        load = 1; reset = 0; data_in = n2;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %H\ndata_out = %H\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 0;
        load = 0; reset = 1; data_in = n2;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %H\ndata_out = %H\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 1;
        load = 0; reset = 1; data_in = n2;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %H\ndata_out = %H\n",
            clk, load, reset, data_in, data_out
        );
        #100;
    end
endmodule