/* teste do módulo flag less */
module less_test #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
);
    reg [WORDSIZE-1:0] input_a;
    reg [WORDSIZE-1:0] input_b;
    wire less; 

    less utt(
        .input_a(input_a),
        .input_b(input_b), 
        .less(less)
    );

    initial begin 

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0002;
        $monitor("input_a = %H\n input_b = %H\n less = %H\n", 
            input_a,
            input_b,
            less
        );
        #100;

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0005;
        $monitor("input_a = %H\n input_b = %H\n less = %H\n", 
            input_a,
            input_b,
            less
        );
        #100;

        input_a = 64'h0000_0000_0000_0001;
        input_b = 64'h1000_0000_0000_0001;
        $monitor("input_a = %H\n input_b = %H\n less = %H\n", 
            input_a,
            input_b,
            less
        );
        #100;

        input_a = 64'h0000_0000_0000_0001;
        input_b = 64'h0000_0000_0000_0005;
        $monitor("input_a = %H\n input_b = %H\n less = %H\n", 
            input_a,
            input_b,
            less
        );
        #100;

    end
endmodule
