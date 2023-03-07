module IFID(
// Inputs: 
input Flush, 
input IFID_write, 
input [63:0] PC_Out, // from PC 
input [31:0] Instruction, // from instruction_memory 
input clk, 
input reset,

// Outputs: 

output reg [63:0] PC_Out_out,
output reg [31:0] Instruction_out

); 

always @(posedge reset or posedge clk) // check if reset has to at only posedge 
begin 
	if (reset == 1 || Flush)
		begin
		PC_Out_out <= 64'b0; 
		Instruction_out <= 32'b0; 
		end 
		
	else if (IFID_write == 1)
		begin 
		PC_Out_out <= PC_Out; 
		Instruction_out <= Instruction; 
		end 
		
end 
endmodule 