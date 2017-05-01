// By Thomas Step

`define FOUR 32'b00000000000000000000000000000100
`include "lshift2.v"

module PCRegister(PC, startPC, Reset_L, Clock, Jump, Branch, Immed, Zero);

	input [31:0] startPC, Immed;
	input Reset_L;
	input Clock, Jump, Branch, Zero;
	output reg[31:0] PC;
  wire BranchSelect;
  wire [31:0] PCwithJump, JumpDest, MuxOut;

  LSHIFT2 LS(Immed, JumpDest);
  assign PCwithJump = PC + JumpDest;
  assign BranchSelect = Branch & Zero;
  MUX32_2to1 MUX3(PC, PCwithJump, BranchSelect, MuxOut);

	always@(negedge Clock or Reset_L)
	begin
		case(Reset_L)
			1'b0: begin // Reset_L is activated
				PC = startPC; // Set PC as startPC
			end
			1'b1: begin // As clock goes on, 
				PC = PC + `FOUR; // Increment PC by 4
        if(BranchSelect==1'b1) // Basically acts as a mux
        begin
          PC = MuxOut + `FOUR;
          $display("Jumping: %d", PC);
        end
			end
		endcase
  end
endmodule

/*module TestPCReg;

   reg [31:0] sPC;
   reg RL;
   wire C;
   wire[31:0] P;

   m555 clk(C);   
   PCRegister PCr( P, sPC, RL, C );

    initial begin
    	$monitor("%0d\tPC = %b; startPC = %b Reset_L = %b;",  $time, P, sPC, RL );

    	#0 sPC = 32'b00000000000000000000000000000000; RL = 1'b0;
    	#10 RL = 1'b1;
    	#100 
    	#100 
    	#100 RL = 1'b0;
    	#10 RL = 1'b1;
    	#100
    	#100
    	#100 $finish;
    end
endmodule*/