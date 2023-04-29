`timescale 1ps/1ps

/* teste do módulo [...] */
module one_bit_register_test #(parameter N = 64) ();
    reg clk;       /* sinal de clock */
    reg load;      /* sinal de load */
    reg reset;     /* sinal de reset */
    reg data_in;   /* dado a ser escrito */
    wire data_out;  /* dado de leitura */
    
    /* instanciação da unit under test */
    one_bit_register uut(
        .clk(clk),
        .load(load),
        .reset(reset),
        .data_in(data_in),
        .data_out(data_out)
    );

    /* início do testbench */
    initial begin
        clk = 0;
        load = 0; reset = 0; data_in = 0;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %B\ndata_out = %B\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 1;
        load = 1; reset = 0; data_in = 1;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %B\ndata_out = %B\n",
            clk, load, reset, data_in, data_out
        );
        #100;      

        clk = 0;
        load = 0; reset = 0; data_in = 0;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %B\ndata_out = %B\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 1;
        load = 1; reset = 0; data_in = 0;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %B\ndata_out = %B\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 0;
        load = 0; reset = 0; data_in = 0;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %B\ndata_out = %B\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 1;
        load = 1; reset = 0; data_in = 1;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %B\ndata_out = %B\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 0;
        load = 0; reset = 0; data_in = 0;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %B\ndata_out = %B\n",
            clk, load, reset, data_in, data_out
        );
        #100;

        clk = 1;
        load = 0; reset = 1; data_in = 0;
        $monitor("clk = %B; load = %B; reset = %B; data_in = %B\ndata_out = %B\n",
            clk, load, reset, data_in, data_out
        );
        #100;  

    end
endmodule