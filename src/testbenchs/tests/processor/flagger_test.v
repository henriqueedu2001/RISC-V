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
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n not_equal = %H\n greater = %H\n less = %H\n u_gretaer = %H\n u_less = %H\n", 
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
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n not_equal = %H\n greater = %H\n less = %H\n u_gretaer = %H\n u_less = %H\n", 
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
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n not_equal = %H\n greater = %H\n less = %H\n u_gretaer = %H\n u_less = %H\n", 
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
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n not_equal = %H\n greater = %H\n less = %H\n u_gretaer = %H\n u_less = %H\n", 
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

        input_a = 64'h1000_0000_0000_0005;
        input_b = 64'h1000_0000_0000_0001;
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n not_equal = %H\n greater = %H\n less = %H\n u_gretaer = %H\n u_less = %H\n", 
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

        input_a = 64'h0000_0000_0000_0002;
        input_b = 64'h1000_0000_0000_0002;
        $monitor("input_a = %H\n input_b = %H\n equal = %H\n not_equal = %H\n greater = %H\n less = %H\n u_gretaer = %H\n u_less = %H\n b = %B\n", 
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