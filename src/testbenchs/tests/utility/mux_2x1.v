`timescale 1ps/1ps

/* teste do módulo [...] */
module mux_2x1_test #(parameter N = 64) ();
    reg [1:0] in;       /* inputs */
    reg sel;            /* seletor */
    wire out;           /* outputs */

    /* instanciação da unit under test */
    mux_2x1 uut(
        .in(in),
        .sel(sel),
        .out(out)
    );

    /* início do testbench */
    initial begin
        in[0] = 0; in[1] = 0; sel = 0;
        $monitor("in[0] = %B; in[1] = %B; sel = %B; \nout = %B\n", in[0], in[1], sel, out);
        #100;

        in[0] = 1; in[1] = 0; sel = 0;
        $monitor("in[0] = %B; in[1] = %B; sel = %B; \nout = %B\n", in[0], in[1], sel, out);
        #100;

        in[0] = 0; in[1] = 0; sel = 1;
        $monitor("in[0] = %B; in[1] = %B; sel = %B; \nout = %B\n", in[0], in[1], sel, out);
        #100;

        in[0] = 0; in[1] = 1; sel = 1;
        $monitor("in[0] = %B; in[1] = %B; sel = %B; \nout = %B\n", in[0], in[1], sel, out);
        #100;
    end
endmodule