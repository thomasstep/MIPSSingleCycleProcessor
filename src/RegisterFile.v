// By Thomas Step
//`include "m555.v"

module RegisterFile(ReadDataOne, ReadDataTwo, ReadRegOne, ReadRegTwo, WriteReg, WriteData, RegWrite, Reset_L, Clock );

	input[31:0] WriteData;
	input[4:0] ReadRegOne, ReadRegTwo, WriteReg;
	input RegWrite, Clock, Reset_L;
	output[31:0] ReadDataOne, ReadDataTwo;
	//reg[31:0] ReadDataOne, ReadDataTwo;

	reg[31:0] Registers [0:31]; // 32 32-bit registers

	/*initial
	begin
		Registers[0] = 32'h00000002;
		Registers[1] = 32'h00000000;
		Registers[2] = 32'h00000000;
		Registers[3] = 32'h00000000;
		Registers[4] = 32'h00000003;
		Registers[5] = 32'h00000000;
		Registers[6] = 32'h00000000;
		Registers[7] = 32'h00000000;
		Registers[8] = 32'h00000001;
		Registers[9] = 32'h00000000;
		Registers[10] = 32'h00000000;
		Registers[11] = 32'h00000000;
		Registers[12] = 32'h00000000;
		Registers[13] = 32'h00000000;
		Registers[14] = 32'h00000000;
		Registers[15] = 32'h00000000;
		Registers[16] = 32'h00000000;
		Registers[17] = 32'h00000000;
		Registers[18] = 32'h00000000;
		Registers[19] = 32'h00000000;
		Registers[20] = 32'h00000000;
		Registers[21] = 32'h00000000;
		Registers[22] = 32'h00000000;
		Registers[23] = 32'h00000000;
		Registers[24] = 32'h00000000;
		Registers[25] = 32'h00000000;
		Registers[26] = 32'h00000000;
		Registers[27] = 32'h00000000;
		Registers[28] = 32'h00000000;
		Registers[29] = 32'h00000000;
		Registers[30] = 32'h00000000;
		Registers[31] = 32'h00000000;
	end*/

	assign ReadDataOne = Registers[ReadRegOne];
	assign ReadDataTwo = Registers[ReadRegTwo];

	always@(negedge Clock or Reset_L)
	begin
		if(RegWrite == 1'b1) 
		begin
			Registers[WriteReg] <= WriteData;
			$display("FirstReg: %d; SecondReg: %d; WriteReg: %d; Data: %d; Reset: %d;\n0 = %d;\n1 = %d;\n2 = %d;\n3 = %d;\n4 = %d;\n5 = %d;\n6 = %d;\n7 = %d;\n8 = %d;\n9 = %d;\n10 = %d;\n11 = %d;\n12 = %d;\n13 = %d;\n14 = %d;\n15 = %d;\n16 = %d;\n17 = %d;\n18 = %d;\n19 = %d;\n20 = %d;\n21 = %d;\n22 = %d;\n23 = %d;\n24 = %d;\n25 = %d;\n26 = %d;\n27 = %d;\n28 = %d;\n29 = %d;\n30 = %d;\n31 = %d;\n",ReadRegOne,ReadRegTwo,WriteReg,WriteData,Reset_L,Registers[0],Registers[1],Registers[2],Registers[3],Registers[4],Registers[5],Registers[6],Registers[7],Registers[8],Registers[9],Registers[10],Registers[11],Registers[12],Registers[13],Registers[14],Registers[15],Registers[16],Registers[17],Registers[18],Registers[19],Registers[20],Registers[21],Registers[22],Registers[23],Registers[24],Registers[25],Registers[26],Registers[27],Registers[28],Registers[29],Registers[30],Registers[31]);
		end
		if(Reset_L == 1'b0) // If Reset_L is activated
		begin // Set all registers to 0
			// I would have used a for loop, but I already had all of this written for testing
			Registers[0] <= 32'h00000000;
			Registers[1] <= 32'h00000000;
			Registers[2] <= 32'h00000000;
			Registers[3] <= 32'h00000000;
			Registers[4] <= 32'h00000000;
			Registers[5] <= 32'h00000000;
			Registers[6] <= 32'h00000000;
			Registers[7] <= 32'h00000000;
			Registers[8] <= 32'h00000000;
			Registers[9] <= 32'h00000000;
			Registers[10] <= 32'h00000000;
			Registers[11] <= 32'h00000000;
			Registers[12] <= 32'h00000000;
			Registers[13] <= 32'h00000000;
			Registers[14] <= 32'h00000000;
			Registers[15] <= 32'h00000000;
			Registers[16] <= 32'h00000000;
			Registers[17] <= 32'h00000000;
			Registers[18] <= 32'h00000000;
			Registers[19] <= 32'h00000000;
			Registers[20] <= 32'h00000000;
			Registers[21] <= 32'h00000000;
			Registers[22] <= 32'h00000000;
			Registers[23] <= 32'h00000000;
			Registers[24] <= 32'h00000000;
			Registers[25] <= 32'h00000000;
			Registers[26] <= 32'h00000000;
			Registers[27] <= 32'h00000000;
			Registers[28] <= 32'h00000000;
			Registers[29] <= 32'h00000000;
			Registers[30] <= 32'h00000000;
			Registers[31] <= 32'h00000000;
		end
    end
endmodule

/*module TestRegFile;

	reg [31:0] WD;	
	reg [4:0] RR1, RR2, WR;
	reg RW, RL;
	wire C;
	wire[31:0] RD1, RD2;

    m555 clk(C);
	RegisterFile rf( RD1, RD2, RR1, RR2, WR, WD, RW, RL, C );

    initial begin
    	$monitor("%0d\tReadReg1 = %b; ReadReg2 = %b WriteReg = %b; WriteData = %b; RegWrite(Signal) = %b; ReadData1 = %b; ReadData2 = %b;",  $time, RR1, RR2, WR, WD, RW, RD1, RD2);

    	#0 RR1 = 5'b01000; RR2 = 5'b00000; WR = 5'b00001; WD = 32'h00000004; RW = 1'b1; RL = 1'b0;
    	#100 RR1 = 5'b00001; RR2 = 5'b00000; WR = 5'b00001; WD = 32'h00000005; RW = 1'b0; RL = 1'b1;
    	#100 RR1 = 5'b00001; RR2 = 5'b00000; WR = 5'b00000; WD = 32'h00000005; RW = 1'b1;
    	#100 RR1 = 5'b00001; RR2 = 5'b00000; WR = 5'b00000; WD = 32'h00000005; RW = 1'b0;
    	#100
    	#100 $finish;
    end
endmodule*/