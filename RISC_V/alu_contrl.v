//Made By M Daud
module Alu_cntrl (
    input [1:0] ALUop,         // 2-bit ALU operation type
    input [6:0] funct7,        // 7-bit funct7 (for R-type instructions)
    input [2:0] funct3,        // 3-bit funct3 (for R-type instructions)
    output reg [3:0] operation // 4-bit ALU control signal
);
    always @(*) begin
        case (ALUop)
            2'b00: begin
                operation = 4'b0010; // Add for Load/Store
            end
            2'b01: begin
                operation = 4'b0110; // Subtract for Branch
            end
            2'b10: begin
                // Decode funct7 and funct3 for R-type instructions
                case ({funct7, funct3})
                    {7'b0000000, 3'b000}: operation = 4'b0010; // Add
                    {7'b0100000, 3'b000}: operation = 4'b0110; // Subtract
                    {7'b0000000, 3'b111}: operation = 4'b0000; // AND
                    {7'b0000000, 3'b110}: operation = 4'b0001; // OR
                    {7'b0000000, 3'b010}: operation = 4'b0111; // Set Less Than
                    default: operation = 4'b1111; // Undefined
                endcase
            end
            default: operation = 4'b1111; // Undefined
        endcase
    end
endmodule
