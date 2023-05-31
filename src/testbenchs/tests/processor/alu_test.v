`timescale 1ps/1ps

/* teste da alu */
module alu_test #(
    parameter WORDSIZE = 64
) ();
    reg [WORDSIZE-1:0] input_a;
    reg [WORDSIZE-1:0] input_b;
    reg [2:0] funct3;
    reg [6:0] funct7;
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
        .funct3(funct3),
        .funct7(funct7),
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
        funct3 = 3'b000;
        funct7 = 7'b0000000;

        $monitor( 
            "input_a: %H", input_a, "\n",
            "input_b: %H", input_b, "\n",
            "funct3: %H", funct3, "\n",
            "funct7: %H", funct7, "\n",
            "result: %H", result, "\n", 
            "flag_equal: %H", flag_equal, "\n",
            "flag_not_equal: %H", flag_not_equal, "\n",
            "flag_greater: %H", flag_greater, "\n",
            "flag_less: %H", flag_less, "\n",
            "flag_u_equal: %H", flag_u_equal, "\n",
            "flag_u_greater: %H", flag_u_greater, "\n",
            "flag_u_less: %H", flag_u_less, "\n"
        );
        #100;
        // tenta agora ok

        input_a = 64'h0000_0000_0000_0007;
        input_b = 64'h0000_0000_0000_0007;

        funct3 = 3'b000;
        funct7 = 7'b0100000;
        $monitor( 
            "input_a: %H", input_a, "\n",
            "input_b: %H", input_b, "\n",
            "funct3: %H", funct3, "\n",
            "funct7: %H", funct7, "\n",
            "result: %H", result, "\n", 
            "flag_equal: %H", flag_equal, "\n",
            "flag_not_equal: %H", flag_not_equal, "\n",
            "flag_greater: %H", flag_greater, "\n",
            "flag_less: %H", flag_less, "\n",
            "flag_u_equal: %H", flag_u_equal, "\n",
            "flag_u_greater: %H", flag_u_greater, "\n",
            "flag_u_less: %H", flag_u_less, "\n"
        );
        #100;

        input_a = 64'h0000_0000_0000_0001;
        input_b = 64'h0000_0000_0000_0007;

        funct3 = 3'b000;
        funct7 = 7'b0000000;
        $monitor( 
            "input_a: %H", input_a, "\n",
            "input_b: %H", input_b, "\n",
            "funct3: %H", funct3, "\n",
            "funct7: %H", funct7, "\n",
            "result: %H", result, "\n", 
            "flag_equal: %H", flag_equal, "\n",
            "flag_not_equal: %H", flag_not_equal, "\n",
            "flag_greater: %H", flag_greater, "\n",
            "flag_less: %H", flag_less, "\n",
            "flag_u_equal: %H", flag_u_equal, "\n",
            "flag_u_greater: %H", flag_u_greater, "\n",
            "flag_u_less: %H", flag_u_less, "\n"
        );
        #100;
    end
endmodule