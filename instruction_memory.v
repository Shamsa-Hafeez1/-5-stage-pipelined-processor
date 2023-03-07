module Instruction_Memory
(
input [63:0] Inst_Address,
output reg [31:0] Instruction
);
reg[7:0] inst_mem [31:0];
initial
begin
// 0x00000033	add x0 x0 x0	Finish: add x0, x0, x0
// 00000000 00000000 000000000 00110011
inst_mem[31] = 8'b00000000; 
inst_mem[30] = 8'b00000000; 
inst_mem[29] = 8'b00000000; 
inst_mem[28] = 8'b00110011;

// 0x002081b3	add x3 x1 x2	add x3, x1, x2
// 00000000 00100000 10000001 10110011
inst_mem[27] = 8'b00000000; 
inst_mem[26] = 8'b00100000; 
inst_mem[25] = 8'b10000001; 
inst_mem[24] = 8'b10110011;

// 0x00022103	lw x2 0(x4)	lw x2, 0(x4) 
// 000000 00000010 00100001 00000011
// changing to ld 
// 000000 00000010 0 010 00010 0000011
// 000000 00000010 0 011 00010 0000011
// 000000 00000010 00110001 00000011 
inst_mem[23] = 8'b00000000; 
inst_mem[22] = 8'b00000010; 
inst_mem[21] = 8'b00100001; 
inst_mem[20] = 8'b00000011;

// 0x001080b3	add x1 x1 x1	Exit:add x1, x1, x1
// 00000000 00010000 10000000 10110011
inst_mem[19] = 8'b00000000; 
inst_mem[18] = 8'b00010000; 
inst_mem[17] = 8'b10000000; 
inst_mem[16] = 8'b10110011;

// 0x00000863	beq x0 x0 16	beq x0, x0, Finish
// 00000000 00001000 01100011
inst_mem[15] = 8'b00000000; 
inst_mem[14] = 8'b00000000; 
inst_mem[13] = 8'b00001000; 
inst_mem[12] = 8'b01100011;

// 0x003100b3	add x1 x2 x3	add x1, x2, x3
// 00000000 00110001 00000000 10110011
inst_mem[11] = 8'b00000000; 
inst_mem[10] = 8'b00110001; 
inst_mem[9] = 8'b00000000; 
inst_mem[8] = 8'b10110011;

// 0x00028663	beq x5 x0 12	beq x5, x0, Exit
// 00000000 00000010 10000110 01100011
inst_mem[7] = 8'b00000000; 
inst_mem[6] = 8'b00000010; 
inst_mem[5] = 8'b10000110; 
inst_mem[4] = 8'b01100011;

// 0x003100b3	add x1 x2 x3	add x1, x2, x3
// 00000000 00110001 00000000 10110011
inst_mem[3] = 8'b00000000; 
inst_mem[2] = 8'b00110001; 
inst_mem[1] = 8'b00000000; 
inst_mem[0] = 8'b10110011; 

end
always @(Inst_Address)
begin
assign Instruction = {inst_mem[Inst_Address+3], inst_mem[Inst_Address+2],inst_mem[Inst_Address+1],inst_mem[Inst_Address]};
end
endmodule
