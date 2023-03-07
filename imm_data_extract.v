module imm_data_extractor(
	input [31:0] instruction, 
	output reg [63:0] imm_data
);

localparam [1:0]
I_type = 2'b00,
S_type = 2'b01, 
B_type = 2'b11; 

wire [6:0] opcode = instruction[6:0]; 

always @(*)
begin 
	case (opcode[6:5])
		I_type:
		begin
			imm_data = {{52{instruction[31]}}, instruction[31:20]}; 
		end 
		S_type:
		begin
			imm_data = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]}; 
		end 
		B_type: 
		begin
			imm_data = {{52{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
		end 
		default:
		begin 
		imm_data = 0;
		end 
	endcase 
end 	
endmodule 