// By Thomas Step

`define FOUR 32'b00000000000000000000000000000100
`include "m555.v"

module PCRegister(PC, startPC, Reset_L, Clock);

	input [31:0] startPC;
	input Reset_L;
	input Clock;
	output reg[31:0] PC;

	always@(posedge Clock or Reset_L)
	begin
		case(Reset_L)
			1'b0: begin // Reset_L is activated
				PC = startPC; // Set PC as startPC
			end
			1'b1: begin // As clock goes on, 
				PC = PC + `FOUR; // Increment PC by 4
			end
		endcase
	end
endmodule

module TestPCReg;

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
endmodule