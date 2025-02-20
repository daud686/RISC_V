//4
`timescale 1ns / 1ps

module PC_Module(
    input clk,rst,en,
    input [31:0]PC_Next,
    output reg [31:0] PC);
    
   

    always @(posedge clk or negedge rst)
    begin
        if(rst == 1'b0)
        begin
            PC <= 32'h00000000;
        end    
        else if(en)
        begin
            PC <= PC_Next;
        end
        else if(rst == 1'b1)
        begin
          PC <= PC_Next;
        end    
    end
endmodule