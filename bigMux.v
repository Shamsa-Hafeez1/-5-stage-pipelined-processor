module BigMux
(
	input [63:0] ReadData, // from IDEX 
	input [63:0] WriteData,// from MemtoReg MUX 
	input [63:0] Mem_Addr, // from EXMEM 
	input [1:0] sel,	   // from Forward Unit	
	output reg [63:0] BigMuxOutput 
);


always @ (*)
begin
	if (sel == 2'b00)
		BigMuxOutput <= ReadData;
		
	else if (sel == 2'b01)
		BigMuxOutput <= WriteData;
		
	else 
		BigMuxOutput <= Mem_Addr; 
end
endmodule 
