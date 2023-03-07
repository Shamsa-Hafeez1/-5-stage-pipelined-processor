module MEM_WB
  (
    //inputs
    input [4:0] Rd,			 
    input [63:0] Read_Data,  
    input [63:0] ALU_Res,    

    //control signals
    input RegWrite, 		
	input MemtoReg, 		

    input clk,     			 
  	input reset, 			 

    //outputs
    output reg [4:0] Rd_out,
    output reg [63:0] Read_Data_out, 
    output reg [63:0] ALU_Res_out,

    //control signals
    output reg RegWrite_out,
	output reg MemtoReg_out
  );


   always @(posedge reset, posedge clk)
    begin
      if (reset)
        begin
          Rd_out <= 0;
          Read_Data_out <= 0; 
          RegWrite_out <= 0;
          MemtoReg_out <= 0;
        end
		
      else 
        begin
          Rd_out <= Rd;
          Read_Data_out <= Read_Data;
          ALU_Res_out <= ALU_Res; 
          RegWrite_out <= RegWrite;
          MemtoReg_out <= MemtoReg;
        end
    end
endmodule