// By Thomas Step

// Possible ALUOp
`define RTYPE   4'b0010 // R-Type instruction
`define LW      4'b0000 // Load Word instruction
`define SW      4'b0000 // Store Word instruction
`define BEQ     4'b0001 // Branch instruction
`define NOP     4'b1111 // NOP instruction
//I-Type (All opcodes except 000000, 00001x, and 0100xx)
`define ADDI    4'b0100
`define ADDIU   4'b0101
`define ANDI    4'b0110
`define BEQ     4'b0001
`define BNE     4'b1011
`define BLEZ    4'b000110
`define BLTZ    4'b000001
`define ORI     4'b0111
`define XORI    4'b1000
`define LUI     4'b001111
`define SLTI    4'b1001
`define SLTIU   4'b1010
`define LB      4'b100000
`define SB      4'b101000
// J-Type (Opcode 00001x)
`define J       4'b1100
`define JAL     4'b000011


// Possible Instruction funct fields
// Information from: https://en.wikibooks.org/wiki/MIPS_Assembly/Instruction_Formats
`define ADDF 6'b100000 // Field where addition is needed
`define ADDUF 6'b100001 // Field where unsigned addition is needed
`define ANDF 6'b100100 // Field where AND is needed
`define ORF 6'b100101 // Field where OR is needed
`define XORF 6'b100110 // Field where XOR is needed
`define SETLTF 6'b101010 // Field where set on less than is needed
`define SLLF 6'b000000 // Field where SLL is needed
`define SLTF 6'b101010 // Field where SLT is needed
`define SLTUF 6'b101011 // Field where SLTU is needed
`define SRAF 6'b000011 // Field where SRA is needed
`define SRLF 6'b000010 // Field where SRL is needed
`define SUBF 6'b100010 // Field where subtraction field
`define SUBUF 6'b100011 // Field where unsigned subtraction is needed

`define DOESNTMATTERF 6'bxxxxxx // Field doesn't matter; normally I-Type


// ALU Operations
`define ADD  4'b0111 // 2's compl add
`define ADDU 4'b0001 // unsigned add
`define AND  4'b0100 // bitwise AND
`define OR   4'b0101 // bitwise OR
`define NOTEQ 4'b1101 // Not equal comparison (for bne exclusively)
`define SLL  4'b1000 // shift left logical
`define SLT  4'b1010 // set result=1 if less than 2's compl
`define SLTU 4'b1011 // set result=1 if less than unsigned
`define SRA  4'b1100 // shift right arithmetic
`define SRL  4'b1001 // shift right logical
`define SUB  4'b0010 // 2's compl subtract
`define SUBU 4'b0011 // unsigned subtract
`define XOR  4'b0110 // bitwise XOR
`define ZERO 4'b1110 // Automatic zero (for jump exclusively)

`define NOP  4'b0000 // do nothing

module ALUControl(ALUFunc, ALUOp, Instruction);

	input[3:0] ALUOp;
	input[5:0] Instruction; // This is the funct field from the instruction
	output[3:0] ALUFunc;
	reg[3:0] ALUFunc;

	always@(Instruction or ALUOp)
	begin
		case(ALUOp)
			`NOP: begin
				ALUFunc = `NOP;
			end
			`RTYPE: begin
				case(Instruction)
					`ADDF: begin
						ALUFunc = `ADD;
					end
					`ADDUF: begin
						ALUFunc = `ADDU;
					end
					`ANDF: begin
						ALUFunc = `AND;
					end
					`ORF: begin
						ALUFunc = `OR;
					end
					`SETLTF: begin
						ALUFunc = `SLT;
					end
					`SLLF: begin
						ALUFunc = `SLL;
					end
					`SLTF: begin
						ALUFunc = `SLT;
					end
					`SLTUF: begin
						ALUFunc = `SLTU;
					end
					`SRAF: begin
						ALUFunc = `SRA;
					end
					`SRLF: begin
						ALUFunc = `SRL;
					end
					`SUBF: begin
						ALUFunc = `SUB;
					end
					`SUBUF: begin
						ALUFunc = `SUBU;
					end
					`XOR: begin
						ALUFunc = `XOR;
					end
				endcase
			end
			`LW: begin
				ALUFunc = `ADD;
			end
			`SW: begin
				ALUFunc = `ADD;
			end
			`BEQ: begin
				ALUFunc = `SUB;
			end
			`BNE: begin
				ALUFunc = `NOTEQ;
			end
			`ADDI: begin
				ALUFunc = `ADD;
			end
			`ADDIU: begin
				ALUFunc = `ADDU;
			end
			`ANDI: begin
				ALUFunc = `AND;
			end
			`ORI: begin
				ALUFunc = `OR;
			end
			`XORI: begin
				ALUFunc = `XOR;
			end
			`SLTI: begin
				ALUFunc = `SLT;
			end
			`SLTIU: begin
				ALUFunc = `SLTU;
			end
			`J: begin
				ALUFunc = `ZERO;
			end
		endcase
	end

endmodule

/*module TestALUCU;

	reg [5:0] I;
	reg[1:0] AO;
	wire[3:0] AF;
      
	ALUControl aCU( AF, AO, I );

    initial begin
    	$monitor("%0d\tI = %b; AO = %b AF = %b;",  $time, I, AO, AF);

    	#0 AO = `RTYPE; I = `ADDF;
    	#10 I = `SUBF;
    	#10 I = `ANDF;
    	#10 I = `ORF;
    	#10 I = `SETLTF;
    	#10 AO = `LSW;
    	#10 AO = `BRANCH;
    	#100 $finish;
    end
endmodule*/