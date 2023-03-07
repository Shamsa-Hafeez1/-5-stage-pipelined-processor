module Program_Counter(
input PCWrite, 
input [63:0] PC_In,
input clk, 
input reset, 
output reg [63:0] PC_Out

); 

	always @(posedge reset or posedge clk)
	begin 	
	if (reset == 1)  
		begin 
			PC_Out <= 64'h0000000000000000; 
		end 
	
	else if (PCWrite)
		begin 
		PC_Out <= PC_In; 
		end 
	end 
	
endmodule 	
