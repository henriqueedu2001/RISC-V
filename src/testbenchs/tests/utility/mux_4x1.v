`timescale 1ps/1ps

/* teste do módulo [...] */
module mux_4x1_test #(parameter N = 64) ();
    reg [3:0] in;       /* inputs */
    reg [1:0] sel;      /* seletor */
    wire out;           /* outputs */

    /* instanciação da unit under test */
    mux_4x1 uut(
        .in(in),
        .sel(sel),
        .out(out)
    );

    /* início do testbench */
    initial begin
        in = 4'b0000; sel = 2'b00;
        $monitor("in = %B; sel = %B; \nout = %B\n", in, sel, out);
        #100;

        in = 4'b0001; sel = 2'b00;
        $monitor("in = %B; sel = %B; \nout = %B\n", in, sel, out);
        #100;

        in = 4'b0000; sel = 2'b01;
        $monitor("in = %B; sel = %B; \nout = %B\n", in, sel, out);
        #100;

        in = 4'b0010; sel = 2'b01;
        $monitor("in = %B; sel = %B; \nout = %B\n", in, sel, out);
        #100;

        in = 4'b0000; sel = 2'b10;
        $monitor("in = %B; sel = %B; \nout = %B\n", in, sel, out);
        #100;

        in = 4'b0100; sel = 2'b10;
        $monitor("in = %B; sel = %B; \nout = %B\n", in, sel, out);
        #100;

        in = 4'b0000; sel = 2'b11;
        $monitor("in = %B; sel = %B; \nout = %B\n", in, sel, out);
        #100;

        in = 4'b1000; sel = 2'b11;
        $monitor("in = %B; sel = %B; \nout = %B\n", in, sel, out);
        #100;
    end
endmodule