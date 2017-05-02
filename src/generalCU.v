// By Thomas Step
// http://www2.engr.arizona.edu/~ece369/Resources/spim/MIPSReference.pdf

// Repetoire of operations for general Control Unit, defined by Instruction[31:26]
`define RTYPE 6'b000000 // R-Type instruction
`define LW 6'b100011 // Load Word instruction
`define SW 6'b101011 // Store Word instruction
`define BEQ 6'b000100 // Branch instruction

// The following opcodes are used in the second part of the project
// Some instructions for the second part of this program are R-Type

//I-Type (All opcodes except 000000, 00001x, and 0100xx)
`define ADDI    6'b001000
`define ADDIU   6'b001001
`define ANDI    6'b001100
`define BEQ     6'b000100
`define BNE     6'b000101
`define BLEZ    6'b000110
`define BLTZ    6'b000001
`define ORI     6'b001101
`define XORI    6'b001110
`define NOP     6'b110110
`define LUI     6'b001111
`define SLTI    6'b001010
`define SLTIU   6'b001011
`define LB      6'b100000
`define SB      6'b101000
// J-Type (Opcode 00001x)
`define J       6'b000010
`define JAL     6'b000011

module generalControl(RegDst, Branch, Jump, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Instruction);

	input[5:0] Instruction; // This is actually the Op field from the instruction
	output RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump;
	output[3:0] ALUOp;
	reg RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump;
	reg[3:0] ALUOp;

	always@(Instruction)
	begin
		case(Instruction)
			`NOP: begin
				RegDst = 1'bx;
				ALUSrc = 1'bx;
				MemtoReg = 1'bx;
				RegWrite = 1'bx;
				MemRead = 1'bx;
				MemWrite = 1'bx;
				Branch = 1'bx;
				Jump = 1'bx;
				ALUOp = 4'b1111;
			end
			`RTYPE: begin
				RegDst = 1'b1;
				ALUSrc = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
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
				Jump = 1'b0;
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
				Jump = 1'b0;
				ALUOp = 4'b0000;
			end
			`BEQ: begin
				RegDst = 1'bx;
				ALUSrc = 1'b0;
				MemtoReg = 1'bx;
				RegWrite = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b1;
				Jump = 1'b0;
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
				Jump = 1'b0;
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
				Jump = 1'b0;
				ALUOp = 4'b0101;	
			end
			`ANDI: begin
				RegDst = 1'b0;
				ALUSrc = 1'b1;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				ALUOp = 4'b0110;	
			end
			`ORI: begin
				RegDst = 1'b0;
				ALUSrc = 1'b1;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				ALUOp = 4'b0111;	
			end
			`XORI: begin
				RegDst = 1'b0;
				ALUSrc = 1'b1;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				ALUOp = 4'b1000;
			end
			`SLTI: begin
				RegDst = 1'b0;
				ALUSrc = 1'b1;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				ALUOp = 4'b1001;
			end
			`SLTIU: begin
				RegDst = 1'b0;
				ALUSrc = 1'b1;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				ALUOp = 4'b1010;
			end
			`BNE: begin
				RegDst = 1'bx;
				ALUSrc = 1'b0;
				MemtoReg = 1'bx;
				RegWrite = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b1;
				Jump = 1'b0;
				ALUOp = 4'b1011;
			end
			`J: begin
				RegDst = 1'bx;
				ALUSrc = 1'b0;
				MemtoReg = 1'bx;
				RegWrite = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				Branch = 1'b0;
				Jump = 1'b1;
				ALUOp = 4'b1100;
			end
		endcase
	end
endmodule

/*module TestGenCU;

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
endmodule*/