module ALU_64_bit
(
	input [63:0] a, 
	input [63:0] b, 
	input [3:0] ALUOp,
	output reg [63:0] Result,
	output ZERO, 
	output GEQ 
	
);
localparam [3:0]
AND = 4'b0000,
OR	= 4'b0001,
ADD	= 4'b0010,
Sub	= 4'b0110,
NOR = 4'b1100;

assign ZERO = (Result == 0); 
assign GEQ = ( a >= b );   

always @ (*)
begin
	case (ALUOp)
		AND: 
		begin
			Result <= a & b; 
		end
		OR:	 
		begin
			Result <= a | b; 
		end
		ADD: 
		begin 
			Result <= a + b; 
		end 
		Sub: 
		begin
			Result <= a - b; 
		end
		NOR: 
		begin
			Result <= ~(a | b); 
		end 
		
		default: Result <= 0;
	endcase
end
endmodule 