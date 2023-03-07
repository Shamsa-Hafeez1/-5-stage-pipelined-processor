
module hazard_detection_unit
  (
 
	input IDEXmemread, 
    input [4:0] Rd_ID_EX, 
    input [4:0] Rs1_IF_ID, 
    input [4:0] Rs2_IF_ID,
    output reg PC_write, 
	output reg IFID_write, 
	output reg ID_Flush_stall 
	
  );
  
  always @ (*)
    begin
	if (IDEXmemread && ((Rd_ID_EX==Rs1_IF_ID) || (Rd_ID_EX==Rs2_IF_ID))) 
		begin
		PC_write <= 1'b0; 
		IFID_write <=1'b0; 
		ID_Flush_stall <=1'b1; 
		end 	
	else 
		begin 
		PC_write <= 1'b1; 
		IFID_write <= 1'b1; 
		ID_Flush_stall <= 1'b0;
		end 
	end

endmodule

