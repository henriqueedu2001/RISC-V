/* unidade de controle */
module control_unit #(
    parameter WORDSIZE = 64,           /* define o tamanho da palavra */
    parameter INSTRUCTION_SIZE = 32    /* tamanho da instrução (32 para o RISC-V) */
) (
    input wire [6:0] opcode,                       /* opcode */
    input wire clk,
    output reg rf_write_en,
    output reg dm_write_en,
    output reg finished

);
    /* Opcodes e tipos*/
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
    localparam
    state0 = 3'b000,
    state1 = 3'b001,
    state2 = 3'b010,
    state3 = 3'b011,
    state4 = 3'b100,
    state5 = 3'b101,
    state6 = 3'b110,
    state7 = 3'b111;

 
    /* sinais separados por tipos */
    always @(posedge clk) begin
        case (opcode)
        opcode_R: begin
            case (state)

            state0: begin 
                /* Reading data from register file*/
                finished <= 0;
                rf_write_en <= 0;
                state <= state1;  
            end

            state1: begin
                /* Realizing Alu operation*/
                rf_write_en <= 0;
                finished <= 0;
                state <= state2;
            end

            state2: begin
                /* Writing data to register file*/
                rf_write_en <= 1;
                state <= state0;
            end
            state3: begin
                /* Finishing operation*/
                finished <= 1;
                rf_write_en <= 0;
                state <= state0;  
            end

            default: begin
                state <= state0;
            end
            endcase

        end
        endcase
    end

endmodule