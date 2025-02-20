`timescale 1ns / 1ps


module top_processor(input clk, rst);
  
  wire [31:0] pc_wire, rd_wire, RD1_wire, RD2_wire,pcnext, imm_ext_wire, alu_result, read_wire, PCplusfour, SrcB_wire, mux_result, Pc_target_wire;
  wire regwrite, memwrite_wire, alu_src_wire, result_src_wire, PCSrc_wire;
  wire [1:0] ImmSrc_wire;
  wire [2:0] alu_control_wire ;
  
  ////////////mux pac to instruction memory
  
   mux_2x1 mux_pc_to_inst(.a(PCplusfour),
                         .b(Pc_target_wire),
                         .sel(PCSrc_wire),
                         .y(pcnext));
  
   //PC module 
   PC_Module pcc(.clk(clk),
         .rst(rst),
         .PC(pc_wire),
         .PC_Next(pcnext));
 
   //instruction memory
   instr_mem inst(.A(pc_wire),
                .rst(rst),
                .rd(rd_wire));        
  
  //PC + 4
   PC_Adder adder_pc(.a(pc_wire),
                 .b(32'd4),
                 .c(PCplusfour));
  
  ///sign extender 
  sign_extend sign(.In(rd_wire),
                   .ImmSrc(ImmSrc_wire),
                   .Imm_ext(imm_ext_wire));
  
  //control unit
  Control_Unit_Top  cntrl_unit(.Op(rd_wire[6:0]), 
                              .RegWrite(regwrite), 
                              .ImmSrc(ImmSrc_wire), 
                              .ALUSrc(alu_src_wire), 
                              .MemWrite(memwrite_wire),
                              .PCSrc(PCSrc_wire),
                              .ResultSrc(result_src_wire),
                              .Branch(),
                              .funct3(rd_wire[14:12]),
                              .funct7(rd_wire[30]),
                              .ALUControl(alu_control_wire));
  
  //register file
   reg_file regs(.A1(rd_wire[19:15]),
                .A2(rd_wire[24:20]),
                .A3(rd_wire[11:7]),
                .clk(clk), 
                .reset(rst), 
                .WE3(regwrite),
                .WD3(mux_result),
                .RD1(RD1_wire), 
                .RD2(RD2_wire));
  
  //mux register file  to alu
   mux_2x1 mux_reg_to_alu(.a(RD2_wire),
                         .b(imm_ext_wire),
                         .sel(alu_src_wire),
                         .y(SrcB_wire)); 
 
 //alu main
  alu alu_m(.A(RD1_wire), 
            .B(SrcB_wire),
            .ALU_Control(alu_control_wire),
            .carry(), 
            .overflow(), 
            .zero(), 
            .negative(),
            .result(alu_result));

 //PC target buffer              
   PC_Adder target_pc(.a(pc_wire),
                 .b(imm_ext_wire),
                 .c(Pc_target_wire));
  
  //data memory
  data_mem data_m(.A(alu_result),
                  .WD(RD2_wire),
                  .clk(clk),
                  .rst(rst),
                  .we(memwrite_wire),
                  .RD(read_wire));
  
  //mux data memory to register
  mux_2x1 mux_datamem_to_regs(.a(alu_result),
                              .b(read_wire),
                              .sel(result_src_wire),
                              .y(mux_result));               
  
endmodule
