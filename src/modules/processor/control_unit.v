/* unidade de controle */
module control_unit #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) (
    input wire clk, rst_n,
    input wire [6:0] opcode,                       /* opcode */
    output reg d_mem_we,
    output reg rf_we,
    input [3:0] alu_flags,
    output [3:0] alu_cmd,
    output alu_src, pc_src, rf_src
);
    /* opcodes e tipos*/
    localparam 
        opcode_R = 7'b0110011,
        opcode_I = 7'b0010011,
        opcode_I_load = 7'b0000011,
        opcode_S = 7'b0100011,
        opcode_B = 7'b1100011,
        opcode_J = 7'b1101111,
        opcode_J_I = 7'b1100111,
        opcode_U = 7'b0110111,
        opcode_U_PC = 7'b0010111, 
        opcode_E = 7'b1110011 ;
    
    /* Parametros de estados */
    reg [2:0] state;
    reg [2:0] next_state;
    
    localparam
    state_fetch = 2'b00,
    state_decode = 2'b01,
    state_execute = 2'b10,
    state_write_back = 2'b11;

always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        state <= state_fetch;
    end
    else begin
        state<= next_state;
    end
end
 
   // maquina de estados da UC
   always @(state) begin
    case(state)
    state_fetch:begin
        rf_we <= 0;
        d_mem_we <= 0; 
        next_state <= state_decode;
    end
    
    state_decode: begin
        rf_we <= 0;
        d_mem_we <= 0; 
        next_state <= state_execute;
    end

    state_execute: begin 
        case(opcode) 
        opcode_R: begin    
            alu_cmd <= 4'b0000;
            rf_we <= 0;
            d_mem_we <= 0; 
            al_src <= 0; 
            pc_src <= 0;
            next_state <= state_write_back;
        end

        opcode_I: begin    
            alu_cmd <= 4'b0001;
            rf_we <= 0;
            d_mem_we <= 0;  
            al_src <= 1;
            pc_src <= 0;
            next_state <= state_write_back;
        end

        opcode_S: begin    
            alu_cmd <= 4'b0010;
            rf_we <= 0;
            d_mem_we <= 0;  
            al_src <= 0;
            pc_src <= 0;
            next_state <= state_write_back;
        end

        opcode_B: begin    
            alu_cmd <= 4'b0011;
            rf_we <= 0;
            d_mem_we <= 0;  
            al_src <= 0;
            pc_src <= 1;
            next_state <= state_write_back;
        end

        opcode_U: begin    
            alu_cmd <= 4'b0100;
            rf_we <= 0;
            d_mem_we <= 0;  
            al_src <= 1;
            pc_src <= 0;
            next_state <= state_write_back;
        end

        opcode_J: begin    
            alu_cmd <= 4'b0101;
            rf_we <= 0;
            d_mem_we <= 0;  
            al_src <= 1;
            pc_src <= 1;
            next_state <= state_write_back;
        end
        
        default: begin
            next_state <= state_write_back;
        end
               
        endcase
    end

    state_write_back: begin 
        rf_we <= 1;
        d_mem_we <= 1;
        next_state <= state_fetch;

    end 

    default: begin
        next_state <= state_fetch;
    end

    endcase
    
   end
endmodule