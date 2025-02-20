//3
`timescale 1ns / 1ps
module data_mem(input [31:0] A,
                input [31:0] WD,
                input clk , we,rst,
                output [31:0] RD);
  
  reg [31:0] Data_mem [1023:0];
  
  //read
  assign RD =  (we == 1'b0) ? Data_mem[A] : 32'h00000000;
  
  //write
  always@(posedge clk)begin
    if(we)
      begin
        Data_mem[A] <= WD;
        
      end
  end
  
  assign RD = (~rst) ? 32'd0 : Data_mem[A];
  
  initial begin
   Data_mem[240] = 32'h00000020;
   Data_mem[8] =   32'h00000123;
  
  end
  
endmodule
