module tb; 
	reg clk; 
	reg reset; 
	
	RISC_V_Processor new_risc(
	.clk(clk), 
	.reset(reset)
	); 

	initial 
	begin 
	reset = 1; 
	clk = 0; 
	end 
	
	always 
	#5 clk = ~clk; 
	
	initial 
	begin
	
	#2 reset = 0; 
	end 
endmodule 