// By Thomas Step

// Possible ALUOp
`define ADDI 4'b0100 // addi instr
`define ADDIU 4'b0101 // addiu instruction
`define ANDI 4'b0110 // andi instruction
`define BRANCH 4'b0001 // Branch instruction
`define LSW 4'b0000 // Load/Store Word instruction
`define ORI 4'b0111 // ori instruction
`define RTYPE 4'b0010 // R-Type instruction


// Possible Instruction funct fields
// Information from: https://en.wikibooks.org/wiki/MIPS_Assembly/Instruction_Formats
`define ADDF 6'b100000 // Field where addition is needed
`define ADDUF 6'b100001 // Field where unsigned addition is needed
`define ANDF 6'b100100 // Field where AND is needed
`define ORF 6'b100101 // Field where OR is needed
`define XORF 6'b100110 // Field where XOR is needed
`define SETLTF 6'b101010 // Field where set on less than is needed
`define SLLF 6'b000000 // Field where SLL is needed
`define SRLF 6'b000010 // Field where SRL is needed
`define SUBF 6'b100010 // Field where subtraction field
`define SUBUF 6'b100011 // Field where unsigned subtraction is needed

`define DOESNTMATTERF 6'bxxxxxx // Field doesn't matter; normally I-Type


// ALU Operations
`define ADD  4'b0111 // 2's compl add
`define ADDU 4'b0001 // unsigned add
`define AND  4'b0100 // bitwise AND
`define OR   4'b0101 // bitwise OR
`define SLL  4'b1000 // shift left logical
`define SLT  4'b1010 // set result=1 if less than 2's compl
`define SLTU 4'b1011 // set result=1 if less than unsigned
`define SRL  4'b1001 // shift right logical
`define SUB  4'b0010 // 2's compl subtract
`define SUBU 4'b0011 // unsigned subtract
`define XOR  4'b0110 // bitwise XOR

`define NOP  4'b0000 // do nothing

module ALUControl(ALUFunc, ALUOp, Instruction);

	input[1:0] ALUOp;
	input[5:0] Instruction; // This is the funct field from the instruction
	output[3:0] ALUFunc;
	reg[3:0] ALUFunc;

	always@(Instruction or ALUOp)
	begin
		case(ALUOp)
			`ADDI: begin
				ALUFunc = `ADD;
			end
			`ADDIU: begin
				ALUFunc = `ADDU;
			end
			`ANDI: begin
				ALUFunc = `AND;
			end
			`BRANCH: begin
				ALUFunc = `SUB;
			end
			`LSW: begin
				ALUFunc = `ADD;
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
		endcase
	end

endmodule

module TestGenCU;

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
endmodule