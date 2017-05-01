initial begin
	Mem[0] = {32'h200a0003};
//            addi   $10, $0, 3
   Mem[1] = {32'h200b0001};
//            addi   $11, $0, 1
	//Mem[2] = {6'd5,5'd10,5'd11,16'd1};
//            bne    $10, $11, Nojump
	Mem[2] = {6'd2,26'd1};
//            jump/skip one instruction
   Mem[3] = {32'h200a0002};
//            addi   $10, $0, 2
   Mem[4] = {32'h200b0002};
//            addi   $11, $0, 2
	Mem[5] = {32'h000a6040};
end