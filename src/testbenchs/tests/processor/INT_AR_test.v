`timescale 1ps/1ps

/* teste da alu */
module alu_int_ar_test #(
    parameter WORDSIZE = 64
) ();
    reg [WORDSIZE-1:0] input_a;
    reg [WORDSIZE-1:0] input_b;
    reg [9:0] operation;
    wire [WORDSIZE-1:0] out;
    wire overflow;

    /* instanciação da unit under test */
    alu_int_ar uut(
        .input_a(input_a),
        .input_b(input_b),
        .operation(operation),
        .out(out),
        .overflow(overflow)
    );

    /* início do testbench */
    initial begin

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0002;

        operation = 10'b0000000000; 
        $monitor("input_a = %H\ninput_b = %H\noperation = %B\nout = %H\n\n", 
            input_a,
            input_b,
            operation,
            out
        ); 
        #100;

        operation = 10'b0000100000; 
        $monitor("input_a = %H\ninput_b = %H\noperation = %B\nout = %H\n\n", 
            input_a,
            input_b,
            operation,
            out
        ); 
        #100;
        
    end
endmodule