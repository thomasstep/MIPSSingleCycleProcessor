// Patrick Wan 722004393
// CSCE 350
// Building Register Files for project 2

module RegisterFile(Read1, Read2, Write1, read1_add, read2_add, write_add, RegWr, CLK, RESET);
	//32 32-bit registers. Registers have 2 read register ports and 1 write register port
    output [31:0] Read1;
    output [31:0] Read2;
    input [31:0] Write1;
	
	reg [31:0] registers [0:31]; //32 32-bit registers
	input [4:0] read1_add, read1_add, write_add; //address of read1, read2, and write
    input RegWr, CLK, RESET; //RegWr = RegWrite signal (necessary to write to register), clock signal, and reset signal
    
	assign Read1=registers[read1_add];
	assign Read2=registers[read2_add];
	
	always @(posedge RESET)
		begin
		registers[0]=0;
		registers[1]=0;
		registers[2]=0;
		registers[3]=0;
		registers[4]=0;
		registers[5]=0;
		registers[6]=0;
		registers[7]=0;
		registers[8]=0;
		registers[9]=0;
		registers[10]=0;
		registers[11]=0;
		registers[12]=0;
		registers[13]=0;
		registers[14]=0;
		registers[15]=0;
		registers[16]=0;
		registers[17]=0;
		registers[18]=0;
		registers[19]=0;
		registers[20]=0;
		registers[21]=0;
		registers[22]=0;
		registers[23]=0;
		registers[24]=0;
		registers[25]=0;
		registers[26]=0;
		registers[27]=0;
		registers[28]=0;
		registers[29]=0;
		registers[30]=0;
		registers[31]=0;
	end

    always @(negedge CLK) 
	begin
        if(RegWr)
		begin
            registers[write_add] = Write1;
		end 
    end
endmodule
