/* teste do módulo flag equal */
module flagger_test #(
    parameter WORDSIZE = 64            /* define o tamanho da palavra */
); 
    reg [WORDSIZE-1:0] input_a;
    reg [WORDSIZE-1:0] input_b;
    wire flag_overflow;          
    wire flag_equal;             
    wire flag_not_equal;         
    wire flag_greater;           
    wire flag_less;              
    wire flag_u_equal;         
    wire flag_u_greater;  
    wire flag_u_less;   

    flagger utt(
        .input_a(input_a),
        .input_b(input_b), 
        .flag_equal(flag_equal), 
        .flag_not_equal(flag_not_equal), 
        .flag_greater(flag_greater), 
        .flag_less(flag_less), 
        .flag_u_equal(flag_u_equal),
        .flag_u_greater(flag_u_greater),
        .flag_u_less(flag_u_less)
    );

    initial begin 

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0002;
        $display("input_a = %D\n input_b = %D\n equal = %D\n not_equal = %D\n greater = %D\n less = %D\n u_gretaer = %D\n u_less = %D\n", 
            input_a,
            input_b,
            flag_equal,
            flag_not_equal,
            flag_greater,
            flag_less,
            flag_u_greater,
            flag_u_less
        );
        #100;

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0005;
        $display("input_a = %D\n input_b = %D\n equal = %D\n not_equal = %D\n greater = %D\n less = %D\n u_gretaer = %D\n u_less = %D\n", 
            input_a,
            input_b,
            flag_equal,
            flag_not_equal,
            flag_greater,
            flag_less,
            flag_u_greater,
            flag_u_less
        );
        #100;

        input_a = 64'h0000_0000_0000_0001;
        input_b = 64'h0000_0000_0000_0001;
        $display("input_a = %D\n input_b = %D\n equal = %D\n not_equal = %D\n greater = %D\n less = %D\n u_gretaer = %D\n u_less = %D\n", 
            input_a,
            input_b,
            flag_equal,
            flag_not_equal,
            flag_greater,
            flag_less,
            flag_u_greater,
            flag_u_less
        );
        #100;

        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0001;
        $display("input_a = %D\n input_b = %D\n equal = %D\n not_equal = %D\n greater = %D\n less = %D\n u_gretaer = %D\n u_less = %D\n", 
            input_a,
            input_b,
            flag_equal,
            flag_not_equal,
            flag_greater,
            flag_less,
            flag_u_greater,
            flag_u_less
        );
        #100;

        input_a = -1;
        input_b = 5;
        $display("input_a = %D\n input_b = %D\n equal = %D\n not_equal = %D\n greater = %D\n less = %D\n u_gretaer = %D\n u_less = %D\n", 
            input_a,
            input_b,
            flag_equal,
            flag_not_equal,
            flag_greater,
            flag_less,
            flag_u_greater,
            flag_u_less
        );
        #100;

        input_a = 5;
        input_b = -1;
        #1;
        $display("input_a = %D\n input_b = %D\n equal = %D\n not_equal = %D\n greater = %D\n less = %D\n u_gretaer = %D\n u_less = %D\n b = %B\n", 
            input_a,
            input_b,
            flag_equal,
            flag_not_equal,
            flag_greater,
            flag_less,
            flag_u_greater,
            flag_u_less,
            input_b[WORDSIZE-1]
        );
        #100;

    end
endmodule