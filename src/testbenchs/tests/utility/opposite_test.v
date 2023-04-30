`timescale 1ps/1ps

/* teste do módulo opposite */
module opposite_test #(
    parameter WORDSIZE = 64          /* define tamanho da palavra */
) ();
    reg [WORDSIZE-1:0] in;           /* inputs */
    wire signed [WORDSIZE-1:0] out;  /* outputs */

    /* instanciação da unit under test */
    opposite uut(
        .num_input(in),
        .num_output(out)
    );

    /* início do testbench */
    initial begin
        in = 64'h0000_0000_0000_0001;
        $monitor("input =  %B (%D)\noutput = %B (%D)\n", in, in, out, out);
        #100;

        in = 64'h0000_0000_0000_ba21;
        $monitor("input =  %B (%D)\noutput = %B (%D)\n", in, in, out, out);
        #100;

        in = 64'h0000_0000_0000_0000;
        $monitor("input =  %B (%D)\noutput = %B (%D)\n", in, in, out, out);
        #100;

        in = 64'hffff_ffff_ffff_ffff;
        $monitor("input =  %B (%D)\noutput = %B (%D)\n", in, in, out, out);
        #100;
    end
endmodule