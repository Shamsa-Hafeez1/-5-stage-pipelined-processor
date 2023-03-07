module EX_MEM
  (
    //inputs
	input Flush, 
    input [4:0] Rd,        // from IDEX 
    input [63:0] Mux, 		// A mux of 2 bits
    input [63:0] ALU_Res,   // from ALU 
	input [63:0] Adder_out, // from adder 
	input [2:0] funct3, 	// Not in diagram , added from our side to include bge; pass functplus sliced 

    //control signals
	input GEQ, 		// from ALU 
    input Zero,		// from ALU 
	input Branch,   // from IDEX 
	input MemRead,  // from IDEX 
	input MemWrite, // from IDEX 
	input RegWrite, // from IDEX 
	input MemtoReg, // from IDEX 

    input clk,    // from main  risc v 
  	input reset, // from main   risc v 
	
    //outputs
    output reg [4:0] Rd_out,
    output reg [63:0] Mux_out, 
    output reg [63:0] ALU_Res_out,
    output reg [63:0] Adder_out_out,
	output reg [2:0] funct3_out,  // Not in diagram , added from our side to include bge;

    //control signals
	output reg GEQ_out, 
    output reg Zero_out,
	output reg Branch_out,
	output reg MemRead_out,
	output reg MemWrite_out,
	output reg RegWrite_out,
	output reg MemtoReg_out
  );

    always @(posedge reset, posedge clk)
    begin
      if (reset || Flush )
        begin

          Rd_out <= 0;
          Mux_out <= 0;
          ALU_Res_out <= 0; 
          Adder_out_out <= 0; 
		  GEQ_out <= 0; 
          Zero_out <= 0;
          Branch_out <= 0;
          MemRead_out <= 0; 
          MemWrite_out <= 0;
          RegWrite_out <= 0;
          MemtoReg_out <= 0;
		  funct3_out <= 0; 

        end

      else 
        begin

          Rd_out <= Rd;
          Mux_out <= Mux;
          ALU_Res_out <= ALU_Res; 
          Adder_out_out <= Adder_out; 
          Zero_out <= Zero;
		  GEQ_out <= GEQ; 
          Branch_out <= Branch; 
          MemRead_out <= MemRead;
          MemWrite_out <= MemWrite;
          RegWrite_out <= RegWrite;
          MemtoReg_out <= MemtoReg;
		  funct3_out <= funct3; 


        end

    end

endmodule