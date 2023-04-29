`timescale 1ps/1ps

/* teste do módulo [...] */
module nome_modulo_test #(parameter N = 64) ();
    reg in;       /* inputs */
    wire out;     /* outputs */

    /* instanciação da unit under test */
    nome_modulo uut(
        .in(in),
        .out(out)
    );

    /* início do testbench */
    initial begin
        $monitor("%B\n%B", in, out);
        #100;
    end
endmodule