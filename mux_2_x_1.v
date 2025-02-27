`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2025 12:12:16
// Design Name: 
// Module Name: mux_2_x_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_2x1 (
    input wire [31:0] a,         // Input 1
    input wire [31:0] b,         // Input 2
    input wire sel,       // Selector
    output reg [31:0] y          // Output
);

    // Always block with case statement
    always @(*) begin
        case (sel)
            1'b0: y = a;  // If sel = 0, output = a
            1'b1: y = b;  // If sel = 1, output = b
            default: y = 1'b0; // Default case (optional, handles unexpected cases)
        endcase
    end
endmodule

