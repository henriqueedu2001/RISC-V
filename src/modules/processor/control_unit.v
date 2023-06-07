/* unidade de controle */
module control_unit #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) (
    input wire [6:0] opcode,                       /* opcode */
    input wire clk,
    output reg rf_write_en,
    output reg dm_write_en,
    output reg finished,
    output reg fetch,
    output reg decode
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

always @(negedge clk) begin
    // $display("State: %b", state);
    // $display("next_state: %b", next_state);
    // $display("Opcode: %b", opcode);
    state <= next_state;
end
 
   // maquina de estados da UC
   always @(posedge clk) begin
    case(state)
    state_fetch:begin
        fetch <= 1;
        decode <= 0;
        rf_write_en <= 0;
        dm_write_en <= 0; 
        finished <= 0;
        next_state <= state_decode;
        finished <= 0;
    end
    
    state_decode: begin
        fetch <= 0;
        decode <= 1;
        rf_write_en <= 0;
        dm_write_en <= 0; 
        finished <= 0;
        next_state <= state_execute;
        finished <= 0;
        
    end

    state_execute: begin 
        case(opcode) 
        opcode_R: begin    
            rf_write_en <= 0;
            dm_write_en <= 0;  
            next_state <= state_write_back;
            finished <= 0;
        end
        
        default: begin
            next_state <= state_write_back;
            finished <= 0; 
        end
               
        endcase
    end

    state_write_back: begin 
        rf_write_en <= 1;
        dm_write_en <= 1;
        next_state <= state_fetch;
        finished <= 1;

    end 

    default: begin
        next_state <= state_fetch;
        finished <= 0;
    end

    endcase
   end
   
    
    /* sinais separados por tipos */
    // always @(posedge clk) begin
    //     case (opcode)
    //     opcode_R: begin
    //         case (state)

    //         state0: begin 
    //             /* Reading data from register file*/
    //             // $display("Reading data from register file");
    //             finished <= 0;
    //             rf_write_en <= 0;
    //             next_state <= state1;
    //             // $display("State: %b", state); 
    //             // $display("Opcode: %b", opcode);

    //         end

    //         state1: begin
    //             /* Realizing Alu operation*/
    //             // $display("Realizing Alu operation");
    //             rf_write_en <= 0;
    //             finished <= 0;
    //             next_state <= state2;
    //         end

    //         state2: begin
    //             /* Writing data to register file*/
    //             // $display("Writing data to register file");
    //             rf_write_en <= 1;
    //             next_state <= state0;
    //         end
    //         state3: begin
    //             /* Finishing operation*/
    //             // $display("Finishing operation");
    //             finished <= 1;
    //             rf_write_en <= 0;
    //             next_state <= state0;  
    //         end

    //         default: begin
    //             next_state <= state0;
    //         end
    //         endcase

    //     end
    //     endcase
    // end

endmodule