/* teste do módulo flag equal */
module equal_test #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
);
    reg [WORDSIZE-1:0] input_a;
    reg [WORDSIZE-1:0] input_b;
    wire equal; 

    equal utt(
        .input_a(input_a),
        .input_b(input_b), 
        .equal(equal)
    );

    initial begin 

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0002;
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n", 
            input_a,
            input_b,
            equal
        );
        #100;

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0005;
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n", 
            input_a,
            input_b,
            equal
        );
        #100;

        input_a = 64'h0000_0000_0000_0001;
        input_b = 64'h0000_0000_0000_0001;
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n", 
            input_a,
            input_b,
            equal
        );
        #100;

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0001;
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n", 
            input_a,
            input_b,
            equal
        );
        #100;

    end
endmodule
