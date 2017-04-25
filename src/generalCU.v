// By Thomas Step
// http://www2.engr.arizona.edu/~ece369/Resources/spim/MIPSReference.pdf

// repetoire of operations for general Control Unit, defined by Instruction[31:26]
`define RTYPE 6'b000000 // R-Type instruction
`define LW 6'b100011 // Load Word instruction
`define SW 6'b101011 // Store Word instruction
`define BRANCH 6'b000100 // Branch instruction
// The following opcodes are used in the second part of the project
// R-Types: addu, subu,
`define ADDI 6'b001000 // addi instr
`define ADDIU 6'b001001 // addiu instruction

module generalControl(RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Instruction);

	input[5:0] Instruction; // This is actually the Op field from the instruction
	output RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	output[3:0] ALUOp;
	reg RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	reg[1:0] ALUOp;

	always@(Instruction)
	begin
		case(Instruction)
			`RTYPE: begin
				RegDst = 1'b1;
				ALUSrc = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				ALUOp = 4'b0010;
			end
			`LW: begin
				RegDst = 1'b0;
				ALUSrc = 1'b1;
				MemtoReg = 1'b1;
				RegWrite = 1'b1;
				MemRead = 1'b1;
				MemWrite = 1'b0;
				Branch = 1'b0;
				ALUOp = 4'b0000;
			end
			`SW: begin
				RegDst = 1'bx;
				ALUSrc = 1'b1;
				MemtoReg = 1'bx;
				RegWrite = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b1;
				Branch = 1'b0;
				ALUOp = 4'b0000;
			end
			`BRANCH: begin
				RegDst = 1'bx;
				ALUSrc = 1'b0;
				MemtoReg = 1'bx;
				RegWrite = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b1;
				ALUOp = 4'b0001;
			end
			`ADDI: begin
				RegDst = 1'b0;
				ALUSrc = 1'b1;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				ALUOp = 4'b0100;	
			end
			`ADDIU: begin
				RegDst = 1'b0;
				ALUSrc = 1'b1;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				ALUOp = 4'b0101;	
			end
		endcase
	end
endmodule

module TestGenCU;

	reg [5:0] I;
	wire  RD, B, MR, MtR, MW, AS, RW;
	wire[1:0] AO;
      
	generalControl gCU( RD, B, MR, MtR, AO, MW, AS, RW, I );

    initial begin
    	$monitor("%0d\tI = %b; RD = %b B = %b; MR = %b; MtR = %b; AO = %b; MW = %b; AS = %b; RW = %b;",  $time, I, RD, B, MR, MtR, AO, MW, AS, RW );

    	#0 I = `RTYPE;
    	#10 I = `LW;
    	#10 I = `SW;
    	#10 I = `BRANCH;
    	#100 $finish;
    end
endmodule