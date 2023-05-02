`timescale 1ps/1ps

/* teste do general mux */
module general_mux_test #(
    parameter WORDSIZE = 64
) ();
    reg [WORDSIZE-1:0] input_a;   /* input a */
    reg [WORDSIZE-1:0] input_b;   /* input b */
    reg sel;                      /* seletor */
    wire [WORDSIZE-1:0] out;      /* output */

    /* instanciação da unit under test */
    general_mux uut(
        .input_a(input_a),
        .input_b(input_b),
        .sel(sel),
        .out(out)
    );

    /* início do testbench */
    initial begin
        input_a = 64'h0000_0000_0000_aaaa;
        input_b = 64'h0000_0000_0000_bbbb;
        sel = 0;
        $monitor("input_a = %H\ninput_b = %H\nsel = %B\nout = %H\n", input_a, input_b, sel, out);
        #100;

        input_a = 64'h0000_0000_0000_aaaa;
        input_b = 64'h0000_0000_0000_bbbb;
        sel = 1;
        $monitor("input_a = %H\ninput_b = %H\nsel = %B\nout = %H\n", input_a, input_b, sel, out);
        #100;
    end
endmodule