`timescale 1ps/1ps

module flagger_padronizado_test #(
    parameter WORDSIZE = 64            
); 
    reg [WORDSIZE-1:0] input_a;
    reg [WORDSIZE-1:0] input_b;
    reg [WORDSIZE-1:0] result; 
    reg funct7;
    wire [3:0] flags; 

    flagger_padronizado utt (
        .input_a(input_a), 
        .input_b(input_b),
        .result(result),
        .funct7(funct7),
        .flags(flags)
    );

    initial begin
      
        input_a = 64'h0000_0000_0000_0005;
        input_b = 64'h0000_0000_0000_0002;
        result = 64'h0000_0000_0000_0000;
        funct7 = 0; 
        $display("input_a = %D\n input_b = %D\n result = %D\n funct7 = %D\n flag_zero = %D flag_msb = %D flag_overflow = %D, extra = %D", 
            input_a,
            input_b,
            result, 
            funct7, 
            flags[0], 
            flags[1],
            flags[2],
            flags[3]
        );
        #100;
        input_a = 64'hf000_0000_0000_0005;
        input_b = 64'hf000_0000_0000_0002;
        result = 64'h0000_0000_0000_0007;
        funct7 = 0; 
        $display("input_a = %B\n input_b = %B\n result = %B\n funct7 = %D\n flag_zero = %D flag_msb = %D flag_overflow = %D, extra = %D", 
            input_a,
            input_b,
            result, 
            funct7, 
            flags[0], 
            flags[1],
            flags[2],
            flags[3]
        );
        #100;

        input_a = 64'h0000_0000_0000_0002;
        input_b = 64'h0000_0000_0000_0002;
        result = 64'h0000_0000_0000_0000;
        funct7 = 1; 
        $display("input_a = %D\n input_b = %D\n result = %D\n funct7 = %D\n flag_zero = %D flag_msb = %D flag_overflow = %D, extra = %D", 
            input_a,
            input_b,
            result, 
            funct7, 
            flags[0], 
            flags[1],
            flags[2],
            flags[3]
        );
        #100;
    end

endmodule