`timescale 1ps/1ps

/* teste do somador de um bit */
module full_adder_test #(parameter N = 64) ();
    reg [N-1:0] a;     /* primeiro número da soma */
    reg [N-1:0] b;     /* segundo número da soma */
    wire [N-1:0] sum;  /* resultado da soma */
    wire overflow;     /* se houve ou não overflow */

    /* instanciação da unit under test */
    full_adder uut(
        .a(a),
        .b(b),
        .sum(sum),
        .overflow(overflow)
    );

    /* início do testbench */
    initial begin
        a = 64'h0000_0000_0000_0002;
        b = 64'h0000_0000_0000_0005;
        $monitor("%D + %D = %D\na   = %B\nb   = %B\nsum = %B\noverflow = ", a, b, sum, a, b, sum, overflow);
        #100;

        a = 64'h0000_0000_f43a_a301;
        b = 64'h0000_0000_b9c2_d427;
        $monitor("%D + %D = %D\na   = %B\nb   = %B\nsum = %B\noverflow = ", a, b, sum, a, b, sum, overflow);
        #100;

        a = 64'h0000_0000_0000_0000;
        b = 64'h0000_0000_0000_ffff;
        $monitor("%D + %D = %D\na   = %B\nb   = %B\nsum = %B\noverflow = ", a, b, sum, a, b, sum, overflow);
        #100;

        a = 64'h7fff_ffff_ffff_ffff;
        b = 64'h8fff_ffff_ffff_0000;
        $monitor("%D + %D = %D\na   = %B\nb   = %B\nsum = %B\noverflow = ", a, b, sum, a, b, sum, overflow);
        #100;

        a = 64'hffff_ffff_ffff_ffff;
        b = 64'hffff_ffff_ffff_ffff;
        $monitor("%D + %D = %D\na   = %B\nb   = %B\nsum = %B\noverflow = ", a, b, sum, a, b, sum, overflow);
        #100;
    end
endmodule