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
    wire [3:0] flags;      

    /* instanciação da unit under test */
    alu uut(
        .input_a(input_a),
        .input_b(input_b),
        .funct3(funct3),
        .funct7(funct7),
        .result(result),
        .flags(flags) 
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
            "flags: %B", flags, "\n"
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
            "flags: %B", flags, "\n"
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
            "flags: %B", flags, "\n"
        );
        #100;

        input_a = 64'hffff_ffff_ffff_ffff;
        input_b = 64'hffff_ffff_ffff_ffff;

        funct3 = 3'b000;
        funct7 = 7'b0000000;
        $monitor( 
            "input_a: %H", input_a, "\n",
            "input_b: %H", input_b, "\n",
            "funct3: %H", funct3, "\n",
            "funct7: %H", funct7, "\n",
            "result: %H", result, "\n", 
            "flags: %B", flags, "\n"
        );
        #100;
    end
endmodule