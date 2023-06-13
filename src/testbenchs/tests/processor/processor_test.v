`timescale 1ps/1ps

module processor_test    #(
        parameter i_addr_bits = 6,
        parameter d_addr_bits = 6,
        parameter WORDSIZE = 64,           /* define o tamanho da palavra */
        parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */ 
    ) (
    );

    reg clk;
    reg rst_n;
    wire [i_addr_bits-1:0] i_mem_addr;
    reg [31:0] i_mem_data;
    wire d_mem_we;
    wire [d_addr_bits-1:0] d_mem_addr;
    wire [63:0] d_mem_data;

    polirv uut
 (
    .clk(clk),
    .rst_n(rst_n),
    .i_mem_addr(i_mem_addr),
    .i_mem_data(i_mem_data),
    .d_mem_we(d_mem_we),
    .d_mem_addr(d_mem_addr),
    .d_mem_data(d_mem_data)
    );
   
    initial begin
    #10
    clk = 0;
    rst_n = 0;
    i_mem_data = 0;

    $display("Clock 0");

    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;

    $display("Clock 1");

    #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;

    $display("Clock 0");

    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;

    $display("Clock 1");

     #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;

    $display("Clock 0");

    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;


    #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;

    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;


     #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;



    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;


    #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;


        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;

        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;

        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;

        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;

        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;

        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;

        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;

        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;


        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;


        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;


        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;


        #10
    clk = 0;
    rst_n = 1;
    i_mem_data = 0;


    #10 
    clk = 1;
    rst_n = 1;
    i_mem_data = 0;


    end
endmodule