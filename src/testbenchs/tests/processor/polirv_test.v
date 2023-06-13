`timescale 1ps/1ps

module polirv_test #(
        parameter i_addr_bits = 6,
        parameter d_addr_bits = 6,
        parameter WORDSIZE = 64,           
        parameter INSTRUCTION_SIZE = 32  
    ) (
    );

    reg clk;
    reg rst_n;
    wire [i_addr_bits-1:0] i_mem_addr;
    wire [31:0] i_mem_data;
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

    // instanciacao Data Memory
    data_memory dm(
        .clk(clk),
        .addr(d_mem_addr),
        .data_input(d_mem_data),
        .write_en(d_mem_we),
        .data_output(d_mem_data)
    );

    // instanciacao Instruction Memory
    instruction_memory im(
        .addr(i_mem_addr),
        .instruction(i_mem_data)
    );

    // início do testbench 
    
    initial begin
    #10
    clk = 0;
    rst_n = 0;
    

    $display("Clock 0");

    #10 
    clk = 1;
    rst_n = 1;
    

    $display("Clock 1");

    #10
    clk = 0;
    rst_n = 1;
    

    $display("Clock 0");

    #10 
    clk = 1;
    rst_n = 1;
    

    $display("Clock 1");

     #10
    clk = 0;
    rst_n = 1;
    

    $display("Clock 0");

    #10 
    clk = 1;
    rst_n = 1;
    


    #10
    clk = 0;
    rst_n = 1;
    

    #10 
    clk = 1;
    rst_n = 1;
    


     #10
    clk = 0;
    rst_n = 1;
    



    #10 
    clk = 1;
    rst_n = 1;
    


    #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    


        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    

        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    

        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    

        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    

        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    

        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    

        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    

        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    


        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    


        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    


        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    


        #10
    clk = 0;
    rst_n = 1;
    


    #10 
    clk = 1;
    rst_n = 1;
    


    end
endmodule