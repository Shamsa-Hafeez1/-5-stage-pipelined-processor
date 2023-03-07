module control_mux(
	// from control unit 
	input Branch,  
	input MemRead,
	input MemtoReg,
	input [1:0] ALUOp,
	input MemWrite,
	input ALUSrc,
	input RegWrite, 
	
	input b,   
	
	input sel, 
	output reg Branch_cm,  
	output reg MemRead_cm,
	output reg MemtoReg_cm,
	output reg [1:0] ALUOp_cm,
	output reg MemWrite_cm,
	output reg ALUSrc_cm,
	output reg RegWrite_cm
);
always @(*)
begin 
if (sel)
begin 
	Branch_cm = b; 
	MemRead_cm = b; 
	MemtoReg_cm = b; 
	ALUOp_cm = {b, b}; 
	MemWrite_cm = b; 
	ALUSrc_cm = b; 
	RegWrite_cm = b;
end 	
else
begin
	Branch_cm = Branch; 
	MemRead_cm = MemRead; 
	MemtoReg_cm = MemtoReg; 
	ALUOp_cm = ALUOp; 
	MemWrite_cm = MemWrite; 
	ALUSrc_cm = ALUSrc; 
	RegWrite_cm = RegWrite;
end 

end 
endmodule 