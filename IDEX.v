module ID_EX(

  //inputs
  input Flush, 
  input [3:0] instruction,  
  input [4:0] rs1, 
  input [4:0] rs2, 
  input [4:0] rd,
  input [63:0] imm_data, 
  input [63:0] ReadData1,
  input [63:0] ReadData2, 
  input [63:0] PC_Out,

  //control signals
  input ALUSrc,
  input [1:0] ALUOp,
  input Branch,
  input MemRead,
  input MemWrite,
  input RegWrite,
  input MemtoReg,
  input clk, 
  input reset,

  //outputs
  output reg [3:0] instruction_out,
  output reg [4:0] rs1_out, 
  output reg [4:0] rs2_out, 
  output reg [4:0] rd_out,
  output reg [63:0] imm_data_out, 
  output reg [63:0] ReadData1_out,
  output reg [63:0] ReadData2_out, 
  output reg [63:0] PC_Out_out,

  //control signals
  output reg ALUSrc_out,
  output reg [1:0] ALUOp_out,
  output reg Branch_out,
  output reg MemRead_out,
  output reg MemWrite_out,
  output reg RegWrite_out,
  output reg MemtoReg_out

);
  always @(posedge reset, posedge clk)
    begin
      if (reset || Flush) // check 
        begin

          instruction_out <= 0;
          rs1_out <= 0;
          rs2_out <= 0; 
          rd_out <= 0; 
          imm_data_out <= 0; 
          ReadData1_out <= 0;
          ReadData2_out <= 0; 
          PC_Out_out <= 0;

          ALUSrc_out <= 0;
          ALUOp_out <= 0;
          Branch_out <= 0; 
          MemRead_out <= 0;
          MemWrite_out <= 0;
          RegWrite_out <= 0;
          MemtoReg_out <= 0;

        end

      else 
        begin

          instruction_out <= instruction;
          rs1_out <= rs1;
          rs2_out <= rs2; 
          rd_out <= rd; 
          imm_data_out <= imm_data; 
          ReadData1_out <= ReadData1;
          ReadData2_out <= ReadData2; 
          PC_Out_out <= PC_Out;

          ALUSrc_out <= ALUSrc;
          ALUOp_out <= ALUOp;
          Branch_out <= Branch; 
          MemRead_out <= MemRead;
          MemWrite_out <= MemWrite;
          RegWrite_out <= RegWrite;
          MemtoReg_out <= MemtoReg;


        end

    end


  endmodule 