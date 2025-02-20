//2
`timescale 1ns / 1ps

module reg_file(input [4:0] A1,
                input [4:0] A2,
                input [4:0] A3,
                input clk, reset, WE3,
                input [31:0] WD3,
                output  [31:0] RD1, RD2);
  
  reg [31:0] registers [31:0];
  
  //read funcationality
  assign RD1 = (!reset) ? 32'd0 : registers[A1];
  
  
  assign RD2 = (!reset) ? 32'd0 : registers[A2];
  
  always@(posedge clk)begin
    if(WE3)
      begin
        registers[A3] <= WD3;
      end
  end

/*integer i;

// Write functionality with asynchronous reset
always @(posedge clk or negedge reset) begin
    if (!reset) begin
        // Reset all registers to 0
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] <= 32'd0; // Non-blocking assignment for reset
        end
    end else if (WE3) begin
        registers[A3] <= WD3; // Write data to register A3
    end
end
*/

  
  initial begin
  
   registers[9] = 32'h000000f4;
   registers[2] = 32'h00000002;
   registers[4] = 32'h0000001c;
      ///Register_memory[5] = 32'h0000002f; 
             ///   Register_memory[4] = 32'h00002004;
   registers[6] = 32'h0000000A;
   registers[5] = 32'h00000006; 
   registers[8] = 32'h00000010;
//  registers[6] = 32'h00000008;
//  registers[9] = 32'h00000003;
  end
  
endmodule