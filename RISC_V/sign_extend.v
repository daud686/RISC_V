//1
`timescale 1ns / 1ps

module sign_extend(input [31:0] In,
                   input [1:0] ImmSrc,
                   output [31:0] Imm_ext);
  
assign Imm_ext = (ImmSrc == 2'b01 ) ? {{20{In[31]}}, In[31:25], In[11:7]} :
                (ImmSrc == 2'b10 ) ? {{20{In[31]}}, In[7], In[30:25], In[11:8], 1'b0} :
                (ImmSrc == 2'b11 ) ? {{12{In[31]}}, In[19:12], In[20], In[30:21], 1'b0}:
                {{20{In[31]}}, In[31:20]} ;
  
endmodule