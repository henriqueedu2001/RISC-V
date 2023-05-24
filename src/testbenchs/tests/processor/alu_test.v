`timescale 1ps/1ps

/* teste da alu */
module alu_test #(
    parameter WORDSIZE = 64
) ();
    reg [WORDSIZE-1:0] input_a;
    reg [WORDSIZE-1:0] input_b;
    reg [5:0] operation;
    wire [WORDSIZE-1:0] result;        
    wire flag_equal;            
    wire flag_not_equal;        
    wire flag_greater;           
    wire flag_less;              
    wire flag_u_equal;           
    wire flag_u_greater;        
    wire flag_u_less;             

    /* instanciação da unit under test */
    alu uut(
        .input_a(input_a),
        .input_b(input_b),
        .operation(operation),
        .result(result),
        .flag_equal(flag_equal),
        .flag_not_equal(flag_not_equal),
        .flag_greater(flag_greater),
        .flag_less(flag_less),
        .flag_u_equal(flag_u_equal),
        .flag_u_greater(flag_u_greater),
        .flag_u_less(flag_u_less)  
    );

    /* início do testbench */
    initial begin
        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0002;

        operation = 6'b000000;
        $monitor("input_a = %H\ninput_b = %H\noperation = %B\nresult = %H\nflag equal = %B\nflag not equal = %B\nflag greater = %B\nflag less = %B\nflag u equal = %B\nflag u greater = %B\nflag u less = %B\n\n", 
            input_a,
            input_b,
            operation,
            result, 
            flag_equal,
            flag_not_equal,
            flag_greater,
            flag_less,
            flag_u_equal,
            flag_u_greater,
            flag_u_less 
        );
        #100;

        input_a = 64'h0000_0000_0000_0007;
        input_b = 64'h0000_0000_0000_0007;

        operation = 6'b000001;
        $monitor("input_a = %H\ninput_b = %H\noperation = %B\nresult = %H\nflag equal = %B\nflag not equal = %B\nflag greater = %B\nflag less = %B\nflag u equal = %B\nflag u greater = %B\nflag u less = %B\n\n", 
            input_a,
            input_b,
            operation,
            result,
            flag_equal,
            flag_not_equal,
            flag_greater,
            flag_less,
            flag_u_equal,
            flag_u_greater,
            flag_u_less 
            
        );
        #100;

        input_a = 64'h0000_0000_0000_0001;
        input_b = 64'h0000_0000_0000_0007;

        operation = 6'b000010;
        $monitor("input_a = %H\ninput_b = %H\noperation = %B\nresult = %H\nflag equal = %B\nflag not equal = %B\nflag greater = %B\nflag less = %B\nflag u equal = %B\nflag u greater = %B\nflag u less = %B\n\n", 
            input_a,
            input_b,
            operation,
            result,
            flag_equal,
            flag_not_equal,
            flag_greater,
            flag_less,
            flag_u_equal,
            flag_u_greater,
            flag_u_less 
            
        );
        #100;
    end
endmodule