`timescale 1ps/1ps

/* teste do módulo [...] */
module program_counter_test #(
    parameter WORDSIZE = 64           /* define o tamanho da palavra */
) ();

    reg clk;
    reg reset;
    wire [WORDSIZE-1:0] addr;

    /* instanciação da unit under test */
    program_counter uut(
        .clk(clk),
        .reset(reset),
        .addr(addr)
    );

    /* início do testbench */
    initial begin
        $monitor("--PROGRAM COUNTER TEST BEGIN--");
        #100;

        $monitor("addr = %H", addr);
        clk = 0; reset = 0; #100; clk = 1; reset = 0; #100;

        $monitor("addr = %H", addr);
        clk = 0; reset = 0; #100; clk = 1; reset = 0; #100;

        $monitor("addr = %H", addr);
        clk = 0; reset = 0; #100; clk = 1; reset = 0; #100;

        $monitor("addr = %H", addr);
        clk = 0; reset = 1; #100; clk = 1; reset = 1; #100;

        $monitor("addr = %H", addr);
        clk = 0; reset = 0; #100; clk = 1; reset = 0; #100;

        $monitor("--PROGRAM COUNTER TEST END--\n");
        #100;
    end
endmodule