//6

module alu(input [31:0] A, B,
           input [2:0] ALU_Control,
           output carry , overflow, zero, negative,
           output [31:0] result);
  
  wire cout;
  wire [31:0] sum;
  
  assign sum = (ALU_Control[0] == 1'b0) ? A + B : (A + ((~B) + 1));
  
  assign {cout , result} = (ALU_Control == 3'b000) ? sum :
                           (ALU_Control == 3'b001) ? sum :
                           (ALU_Control == 3'b010) ? A & B :
                           (ALU_Control == 3'b011) ? A | B :
                           (ALU_Control == 3'b101) ? {{32{1'b0}}, (sum[31])} :
  {33{1'b0}};
  
  assign overflow = ((sum[31] ^ A[31]) &
    (~(ALU_Control[0] ^ B[31] ^ A[31])) &
                     (~ALU_Control[1]));
  assign carry = ((~ALU_Control[1]) & cout);
  assign zero = &(~result);
  assign negative = result[31];
  
endmodule