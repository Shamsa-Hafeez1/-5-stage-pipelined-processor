module RISC_V_Processor( // with pipelining 
input clk, 
input reset
); 
	wire [63:0] PC_In; 
	wire [63:0] PC_Out; 
	wire [31:0] Instruction; 
	wire [63:0] PC_Out_ifid; 
	wire [31:0] Instruction_ifid; 
	wire [6:0] opcode; 
	wire [4:0] rd;  
	wire [2:0] funct3; 
	wire [4:0] rs1; 
	wire [4:0] rs2; 
	wire [6:0] funct7; 
	wire [63:0] ReadData1; 
	wire [63:0] ReadData2; 
	wire [63:0] imm_data; 
	wire Branch; 
	wire MemRead; 
	wire MemtoReg; 
	wire [1:0] ALUOp; 
	wire MemWrite; 
	wire ALUSrc; 
	wire RegWrite; 
	wire [3:0] instruction_idex; 
	wire [4:0] rs1_idex; 
	wire [4:0] rs2_idex; 
	wire [4:0] rd_idex; 
	wire [63:0] imm_data_idex;  
	wire [63:0] ReadData1_idex; 
	wire [63:0] ReadData2_idex;  
	wire [63:0] PC_Out_idex; 
	wire ALUSrc_idex; 
	wire [1:0] ALUOp_idex; 
	wire Branch_idex; 
	wire MemRead_idex; 
	wire MemWrite_idex; 
	wire RegWrite_idex; 
	wire MemtoReg_idex; 
	wire [63:0] adder2_output;
	wire [63:0] BigMux1_output; 
	wire [63:0] BigMux2_output; 
	wire [63:0] alusrc_mux_output; 
	wire ZERO; 
	wire [63:0] ALU_64_bit_Result; 
	wire [4:0] rd_exmem; 
	wire [63:0] mux_out_exmem; 
	wire [63:0] ALU_res_exmem; 
	wire [63:0] Adder_exmem; 
	wire [2:0] funct3_exmem; 
	wire GEQ_exmem; 
	wire ZERO_exmem; 
	wire Branch_exmem; 
	wire MemRead_exmem; 
	wire MemWrite_exmem; 
	wire MemtoReg_exmem; 
	wire [3:0] Operation; 
	wire [63:0] Read_Data_DataMemory; 
	wire [4:0] green; 
	wire [63:0] Read_Data_memwb; 
	wire [63:0]  ALU_Res_memwb; 
	wire RegWrite_memwb; 
	wire MemtoReg_memwb; 
	wire [63:0] brown; 
	wire [1:0] Forward_A; 
	wire [1:0] Forward_B; 
	wire [63:0] Branch_mux_output; 
	wire [63:0] Adder_1_output; 
	wire GEQ; 
	wire PC_Write_hdu; 
	wire IFID_write_hdu; 
	wire ID_Flush_stall_hdu; 
	wire Branch_cm; 
	wire MemRead_cm; 
	wire MemtoReg_cm; 
	wire [1:0] ALUOp_cm; 
	wire MemWrite_cm;
	wire ALUSrc_cm;
	wire RegWrite_cm; 
	wire Flush_yes; 
	
	branch_detection_unit bdu(
	.Branch(((Branch_exmem & ZERO_exmem & (funct3_exmem == 3'b000) ) | (GEQ_exmem & Branch_exmem & (funct3_exmem == 3'b101)))), // from branch mux 
	.Flush_yes(Flush_yes) 
	); 
	
	hazard_detection_unit hdu
	(
	.IDEXmemread(MemRead_idex),  // from idex 
    .Rd_ID_EX(rd_idex),          // from idex 
    .Rs1_IF_ID(rs1),             // from instruction parser 
    .Rs2_IF_ID(rs2),             // from instruction parser 
    .PC_write(PC_Write_hdu), 
	.IFID_write(IFID_write_hdu), 
	.ID_Flush_stall(ID_Flush_stall_hdu)
	
	);
	
	Program_Counter pc(
	.PCWrite(PC_Write_hdu),      // from hazard_detection_unit
	.PC_In(Branch_mux_output),   // from Branch MUX 
	.clk(clk),                   // from input 
	.reset(reset),  			 // from input
	.PC_Out(PC_Out) 
	); 

	Instruction_Memory im(
	.Inst_Address(PC_Out), 		 // from Program_Counter
	.Instruction(Instruction)    
	); 
	
	Adder adder1(
	.a(PC_Out), 				// from Program_Counter		
	.b(64'h0000000000000004), 
	.out(Adder_1_output) 
	);  
	
	IFID IfId(
	.Flush(Flush_yes), 			 // from branch detection unit 
	.IFID_write(IFID_write_hdu), // from hazard dedection unit 
	.Instruction(Instruction),   // from Instruction_Memory 
	.PC_Out(PC_Out),		     // from Program_Counter 
	.clk(clk),                   // from input 					 
	.reset(reset),		 	     // from input 		
	.PC_Out_out(PC_Out_ifid), 
	.Instruction_out(Instruction_ifid)
	);

	instruction_parser ip(
	.instruction(Instruction_ifid),   // from ifid 
	.opcode(opcode), 
	.rd(rd),  
	.funct3(funct3), 
	.rs1(rs1),
	.rs2(rs2),
	.funct7() 					//remains empty because not needed 
	); 

	registerFile registers( 
	.WriteData(brown),  		// from memtoreg mux  			 
    .RS1(rs1), 					// from instruction_parser	      
    .RS2(rs2),     				// from instruction_parser            
    .RD(green),  				// from memwb 			           
    .RegWrite(RegWrite_memwb),  // from memwb  
	.clk(clk),    				// input          	
	.reset(reset), 				// input  			 	
    .ReadData1(ReadData1),  
    .ReadData2(ReadData2)
	); 
	
	control_mux cm(
	.Branch(Branch),  		 // from Control_Unit
	.MemRead(MemRead), 		 // from Control_Unit
	.MemtoReg(MemtoReg),	 // from Control_Unit
	.ALUOp(ALUOp), 			// from Control_Unit
	.MemWrite(MemWrite), // from Control_Unit
	.ALUSrc(ALUSrc), // from Control_Unit
	.RegWrite(RegWrite),  // from Control_Unit
	.b(1'b0),          // only has zero in it 
	.sel(ID_Flush_stall_hdu), // from hazard detection unit 
	.Branch_cm(Branch_cm),  
	.MemRead_cm(MemRead_cm),
	.MemtoReg_cm(MemtoReg_cm),
	.ALUOp_cm(ALUOp_cm),
	.MemWrite_cm(MemWrite_cm),
	.ALUSrc_cm(ALUSrc_cm),
	.RegWrite_cm(RegWrite_cm)
	);

	Control_Unit cu(
	.Opcode(opcode), 			// from instruction_parser		
	.Branch(Branch),  
	.MemRead(MemRead),
	.MemtoReg(MemtoReg),
	.ALUOp(ALUOp),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite)      
	);

	imm_data_extractor ime(
	.instruction(Instruction_ifid), // from ifid 
	.imm_data(imm_data)
	);
	
	ID_EX idex(
  .Flush(Flush_yes), // from branch_detection_unit
  .instruction( { Instruction_ifid[30] , Instruction_ifid[14:12]}), // from ifid 
  .rs1(rs1), 					// from instruction_parser
  .rs2(rs2), 					// from instruction_parser 
  .rd(rd),					    // from instruction_parser
  .imm_data(imm_data), 		    // from imm_data_extractor
  .ReadData1(ReadData1),        // from Register File 
  .ReadData2(ReadData2),        // from Register File 
  .PC_Out(PC_Out_ifid),         // from ifid 
  .ALUSrc(ALUSrc_cm),              // from Control_Unit // from Control_Unit MUX 
  .ALUOp(ALUOp_cm),                // from Control_Unit// from Control_Unit MUX
  .Branch(Branch_cm),              // from Control_Unit// from Control_Unit MUX
  .MemRead(MemRead_cm),            // from Control_Unit// from Control_Unit MUX
  .MemWrite(MemWrite_cm),          // from Control_Unit// from Control_Unit MUX
  .RegWrite(RegWrite_cm),          // from Control_Unit// from Control_Unit MUX
  .MemtoReg(MemtoReg_cm),          // from Control_Unit// from Control_Unit MUX
  .clk(clk ),                      // input 
  .reset(reset),                   // input 
  .instruction_out(instruction_idex),
  .rs1_out(rs1_idex), 
  .rs2_out(rs2_idex), 
  .rd_out(rd_idex),
  .imm_data_out(imm_data_idex), 
  .ReadData1_out(ReadData1_idex),
  .ReadData2_out(ReadData2_idex), 
  .PC_Out_out(PC_Out_idex),
  .ALUSrc_out(ALUSrc_idex),
  .ALUOp_out(ALUOp_idex),
  .Branch_out(Branch_idex),
  .MemRead_out(MemRead_idex),
  .MemWrite_out(MemWrite_idex),
  .RegWrite_out(RegWrite_idex),
  .MemtoReg_out(MemtoReg_idex)
	);


	Adder adder2(
	.a(PC_Out_idex),    	    // from idex    
	.b(imm_data_idex << 1),     // from idex 
	.out(adder2_output) 
	);

	BigMux big1(
	.ReadData(ReadData1_idex), // from idex 
	.WriteData(brown),         // from memtoreg mux 
	.Mem_Addr(ALU_res_exmem),  // exmem 
	.sel(Forward_A),           // Forwarding_Unit
	.BigMuxOutput(BigMux1_output)
	);
	
	BigMux big2(
	.ReadData(ReadData2_idex), // from idex 
	.WriteData(brown),         // from memtoreg mux 
	.Mem_Addr(ALU_res_exmem),// exmem 
	.sel(Forward_B),// Forwarding_Unit
	.BigMuxOutput(BigMux2_output)
	);
	

	Mux ALUSrc_MUX(
	.a(BigMux2_output), 	     // from BigMUX 2 		
	.b(imm_data_idex),           // from idex       
	.sel(ALUSrc_idex),           // from idex 
	.data_out(alusrc_mux_output)
	);
	
	ALUControl alu_control(
	.ALUOp(ALUOp_idex), 	    // from idex 		      
	.Funct( instruction_idex ), // from idex 
	.Operation(Operation)
	);

	ALU_64_bit ALU(
	.a(BigMux1_output),        // from BigMux1           
	.b(alusrc_mux_output),     // from alusrc mux 
	.ALUOp(Operation),	       // from ALUControl	 
	.Result(ALU_64_bit_Result),
	.ZERO(ZERO), 
	.GEQ(GEQ)
	);

	EX_MEM exmem(
	.Flush(Flush_yes),              // from branch_detection_unit
	.Rd(rd_idex), 			  		// from idex 
	.Mux(BigMux2_output),    	    // from BigMUX 2 
	.ALU_Res(ALU_64_bit_Result),    // from ALU_64_bit
	.Adder_out(adder2_output),      // from adder2 
	.funct3(instruction_idex[2:0]), // from idex only funct 3 passes 
	.GEQ(GEQ), 					    // from ALU 
	.Zero(ZERO),					// from ALU 
	.Branch(Branch_idex),			// from idex 
	.MemRead(MemRead_idex),			// from idex 
	.MemWrite(MemWrite_idex),		// from idex 
	.RegWrite(RegWrite_idex),		// from idex 
	.MemtoReg(MemtoReg_idex),		// from idex 
	.clk(clk), 						// clk input 
	.reset(reset), 					// reset input 
	.Rd_out(rd_exmem),
	.Mux_out(mux_out_exmem),
	.ALU_Res_out(ALU_res_exmem),
	.Adder_out_out(Adder_exmem),
	.funct3_out(funct3_exmem),
	.GEQ_out(GEQ_exmem),
	.Zero_out(ZERO_exmem),
	.Branch_out(Branch_exmem),
	.MemRead_out(MemRead_exmem),
	.MemWrite_out(MemWrite_exmem), 
	.RegWrite_out(RegWrite_exmem),
	.MemtoReg_out(MemtoReg_exmem)
	);

	Data_Memory dm(
	.Mem_Addr(ALU_res_exmem), 		// from exmem        
	.Write_Data(mux_out_exmem), 	// from exmem   
	.clk(clk),           			// input      
	.MemWrite(MemWrite_exmem), 	  	// from exmem  
	.MemRead(MemRead_exmem),        // from exmem 
	.Read_Data(Read_Data_DataMemory)
	); 

	MEM_WB memwb(
	.Rd(rd_exmem), 					  // from exmem 
	.Read_Data(Read_Data_DataMemory), // from Data_Memory
	.ALU_Res(ALU_res_exmem), 		  // from exmem 
	.RegWrite(RegWrite_exmem),        // from exmem 
	.MemtoReg(MemtoReg_exmem),        // from exmem 
	.clk(clk),			// clk 
	.reset(reset),     // reset 
	.Rd_out(green),
	.Read_Data_out(Read_Data_memwb),
	.ALU_Res_out(ALU_Res_memwb),
	.RegWrite_out(RegWrite_memwb),
	.MemtoReg_out(MemtoReg_memwb)
	);
	
	
	Mux MemtoReg_MUX(
	.a( ALU_Res_memwb), 	   // from memwb 		
	.b(Read_Data_memwb),       // from memwb          
	.sel(MemtoReg_memwb),      // from memwb 
	.data_out(brown) 
	);
	
	Forwarding_Unit fd(
	.Rs1(rs1_idex), 	   // from idex
	.Rs2(rs2_idex), 	   // from idex 
	.Rd_EX_MEM(rd_exmem),  // from exmem 
	.Rd_MEM_WB(green), 	   // from memwb 
	.RegWrite_EX_MEM(RegWrite_exmem), // from exmem 
	.RegWrite_MEM_WB(RegWrite_memwb), // from memwb 
	.Forward_A(Forward_A),
	.Forward_B(Forward_B)
	);
	
	Mux Branch_MUX(
	.a(Adder_1_output), // from adder1  			 	
	.b(Adder_exmem),    //  from exmem                        
	.sel((Branch_exmem & ZERO_exmem & (funct3_exmem == 3'b000) ) | (GEQ_exmem & Branch_exmem & (funct3_exmem == 3'b101))), // from EXMEM  
	.data_out(Branch_mux_output)       
	);

endmodule 