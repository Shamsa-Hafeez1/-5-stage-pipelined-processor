module Forwarding_Unit
  (
    //inputs
    input [4:0] Rs1, 
    input [4:0] Rs2,
    input [4:0] Rd_EX_MEM,
    input [4:0] Rd_MEM_WB,

    //control signals
	input RegWrite_EX_MEM,
	input RegWrite_MEM_WB,	

    //outputs
    output reg [1:0] Forward_A, 
    output reg [1:0] Forward_B
  );

  always @ (*)
    begin
     //Forward A

      //EX Hazard
      if (RegWrite_EX_MEM && Rd_EX_MEM != 0 && Rd_EX_MEM == Rs1)
        Forward_A = 2'b10;

      //MEM Hazard
      else if ((RegWrite_MEM_WB && (Rd_MEM_WB != 0) && Rd_MEM_WB == Rs1) &&!(RegWrite_EX_MEM && Rd_EX_MEM != 0 && Rd_EX_MEM == Rs1))
        Forward_A = 2'b01;

      else
        Forward_A = 2'b00;

      //Forward B

      //EX Hazard
      if (RegWrite_EX_MEM && Rd_EX_MEM != 0 && Rd_EX_MEM == Rs2)
        Forward_B = 2'b10;

      //MEM Hazard
      else if ((RegWrite_MEM_WB && (Rd_MEM_WB != 0) && Rd_MEM_WB == Rs2)&& !(RegWrite_EX_MEM && Rd_EX_MEM != 0 && Rd_EX_MEM == Rs2))
        Forward_B = 2'b01;

       else
        Forward_B = 2'b00;
		
    end

endmodule
