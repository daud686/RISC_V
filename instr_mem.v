`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2025 14:48:01
// Design Name: 
// Module Name: instr_mem
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

//5

module instr_mem (
    input [31:0] A,      // Address input
    input rst,           // Reset input
    output reg [31:0] rd // Read data output
);

    // Declare memory array for instructions
    reg [31:0] mem[1023:0];

    // Read functionality
    always @(*) begin
        if (!rst) begin
            rd = 32'h00000000; // Reset output
        end else begin
            rd = mem[A[31:2]]; // Read from memory using word-aligned address
        end
    end

    // Initialize memory with predefined instructions
    initial begin
    $readmemh("instr.mem", mem);
//        mem[0] = 32'h005271B3;
//        mem[1] = 32'h004363B3;

  //      mem[1] = 32'h00832383;
        // Additional instructions can be added here.
    end

endmodule










//module ints_mem(input [31:0] A,
//               input rst,
//                output [31:0] rd);
  
//  reg [31:0] mem[1023:0];
  
//  assign rd = (rst == 1'b0) ? 32'h00000000 : mem[A[31:2]];
  
//  initial begin
//    mem[0] = 32'hFFC4A303;
//    mem[1] = 32'h00832383;
////mem[0] = 32'h0064A423;
////mem[1] = 32'h00B62423;
////mem[2] = 32'h00B62423;
////mem[4] = 32'hFFC4A303;
////mem[5] = 32'h0064A423;
////mem[6] = 32'h0062E233;

//  end
  
//endmodule
