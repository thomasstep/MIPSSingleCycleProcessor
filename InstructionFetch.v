module SingleCycleProc(CLK, Reset_L, startPC, dmemOut);
   input 	Reset_L, CLK;
   input [31:0] startPC;
   output [31:0] dmemOut;



//
// INSERT YOUR CPU MODULES HERE
//

//if PC is implemented using wire[31:0] PC and wire [31:0] Instr then...

//Using InstrMem module from IdealMemory 
InstrMem IR(PC,Instr);
