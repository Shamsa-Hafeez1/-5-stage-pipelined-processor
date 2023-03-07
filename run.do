vlib work 
vlog tb.v branch_detection_unit.v bigMux.v control_mux.v EXMEM.v hazard_detection_unit.v forwarding_unit.v IDEX.v IFID.v MEMWB.v adder.v alu_control.v control_unit.v data_memory.v instruction_memory.v instruction_parser.v mux.v pc.v risc_v_processor.v registerFile.v imm_data_extract.v ALU_64_bit.v 
vsim -novopt work.tb 
view wave 
#add wave -r /* 
#add wave sim:/tb/*
do wave.do
add wave sim:/tb/new_risc/dm/DataMemory 
add wave sim:/tb/new_risc/registers/Registers
view wave 
run 300ns 	