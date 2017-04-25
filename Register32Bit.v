module DFF32_PC(Q, Qbar, C, D, PREbar, CLRbar, Wen);
	input  [31:0] D;
	input  C, PREbar, CLRbar, Wen;
	output [31:0] Q, Qbar;
	
	DFF_PC dff0(Q[0], Qbar[0], C, D[0], PREbar, CLRbar, Wen);
    DFF_PC dff1(Q[1], Qbar[1], C, D[1], PREbar, CLRbar, Wen);
    DFF_PC dff2(Q[2], Qbar[2], C, D[2], PREbar, CLRbar, Wen);
    DFF_PC dff3(Q[3], Qbar[3], C, D[3], PREbar, CLRbar, Wen);
    DFF_PC dff4(Q[4], Qbar[4], C, D[4], PREbar, CLRbar, Wen);
    DFF_PC dff5(Q[5], Qbar[5], C, D[5], PREbar, CLRbar, Wen);
    DFF_PC dff6(Q[6], Qbar[6], C, D[6], PREbar, CLRbar, Wen);
    DFF_PC dff7(Q[7], Qbar[7], C, D[7], PREbar, CLRbar, Wen);

    DFF_PC dff8(Q[8], Qbar[8], C, D[8], PREbar, CLRbar, Wen);
    DFF_PC dff9(Q[9], Qbar[9], C, D[9], PREbar, CLRbar, Wen);
    DFF_PC dff10(Q[10], Qbar[10], C, D[10], PREbar, CLRbar, Wen);
    DFF_PC dff11(Q[11], Qbar[11], C, D[11], PREbar, CLRbar, Wen);
    DFF_PC dff12(Q[12], Qbar[12], C, D[12], PREbar, CLRbar, Wen);
    DFF_PC dff13(Q[13], Qbar[13], C, D[13], PREbar, CLRbar, Wen);
    DFF_PC dff14(Q[14], Qbar[14], C, D[14], PREbar, CLRbar, Wen);
    DFF_PC dff15(Q[15], Qbar[15], C, D[15], PREbar, CLRbar, Wen);

    DFF_PC dff16(Q[16], Qbar[16], C, D[16], PREbar, CLRbar, Wen);
    DFF_PC dff17(Q[17], Qbar[17], C, D[17], PREbar, CLRbar, Wen);
    DFF_PC dff18(Q[18], Qbar[18], C, D[18], PREbar, CLRbar, Wen);
    DFF_PC dff19(Q[19], Qbar[19], C, D[19], PREbar, CLRbar, Wen);
    DFF_PC dff20(Q[20], Qbar[20], C, D[20], PREbar, CLRbar, Wen);
    DFF_PC dff21(Q[21], Qbar[21], C, D[21], PREbar, CLRbar, Wen);
    DFF_PC dff22(Q[22], Qbar[22], C, D[22], PREbar, CLRbar, Wen);
    DFF_PC dff23(Q[23], Qbar[23], C, D[23], PREbar, CLRbar, Wen);

    DFF_PC dff24(Q[24], Qbar[24], C, D[24], PREbar, CLRbar, Wen);
    DFF_PC dff25(Q[25], Qbar[25], C, D[25], PREbar, CLRbar, Wen);
    DFF_PC dff26(Q[26], Qbar[26], C, D[26], PREbar, CLRbar, Wen);
    DFF_PC dff27(Q[27], Qbar[27], C, D[27], PREbar, CLRbar, Wen);
    DFF_PC dff28(Q[28], Qbar[28], C, D[28], PREbar, CLRbar, Wen);
    DFF_PC dff29(Q[29], Qbar[29], C, D[29], PREbar, CLRbar, Wen);
    DFF_PC dff30(Q[30], Qbar[30], C, D[30], PREbar, CLRbar, Wen);
    DFF_PC dff31(Q[31], Qbar[31], C, D[31], PREbar, CLRbar, Wen);
endmodule

module m555(clock);
    parameter InitDelay = 10, Ton = 50, Toff = 50;
    output clock;
    reg clock;

    initial begin
        #InitDelay clock = 1;
    end

    always begin
        #Ton clock = ~clock;
        #Toff clock = ~clock;
    end
endmodule

module DFF_PC(Q, Qbar, C, D, PREbar, CLRbar, Wen);
    input D, C, PREbar, CLRbar, Wen;
    output Q, Qbar;
    wire notclock, masttoslaveq, masttoslaveqbar, Clock, SlavedToQbar, SlavedToQ, dToQ, dToQbar;

    assign Clock = C & Wen;
    assign notclock = ~Clock;

    assign #1 dToQ = D ~& Clock;
    assign #1 dToQbar = ~D ~& Clock;
    assign #1 masttoslaveq = ~(masttoslaveqbar & dToQ & PREbar);
    assign #1 masttoslaveqbar = ~(masttoslaveq & dToQbar & CLRbar);

    assign #1 SlavedToQ = masttoslaveq ~& notclock;
    assign #1 SlavedToQbar = masttoslaveqbar ~& notclock;
    assign #1 Q = ~(Qbar & SlavedToQ & PREbar);
    assign #1 Qbar = ~(Q & SlavedToQbar & CLRbar);
endmodule
