`timescale 1ps/1ps

/* teste da alu */
module alu_test #(
    parameter WORDSIZE = 64
) ();
    reg [WORDSIZE-1:0] input_a;
    reg [WORDSIZE-1:0] input_b;
    reg [2:0] operation;
    wire [WORDSIZE-1:0] result;
    wire overflow;

    /* instanciação da unit under test */
    alu uut(
        .input_a(input_a),
        .input_b(input_b),
        .operation(operation),
        .result(result),
        .overflow(overflow)
    );

    /* início do testbench */
    initial begin
        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0002;
        operation = 3'b000;
        $monitor("input_a = %H\ninput_b = %H\noperation = %B\nresult = %H\noverflow = %B\n", 
            input_a,
            input_b,
            operation,
            result,
            overflow
        );
        #100;

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0002;
        operation = 3'b001;
        $monitor("input_a = %H\ninput_b = %H\noperation = %B\nresult = %H\noverflow = %B\n", 
            input_a,
            input_b,
            operation,
            result,
            overflow
        );
        #100;
    end
endmodule