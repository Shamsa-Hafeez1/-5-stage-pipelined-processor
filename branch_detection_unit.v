module branch_detection_unit(
input Branch, 
output reg Flush_yes 
); 

always@(*)
begin 
if (Branch)
begin 
Flush_yes <= 1;
end  

else 
begin 
Flush_yes <= 0; 
end 
end 
endmodule 