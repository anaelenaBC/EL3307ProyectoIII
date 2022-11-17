module subsistemaDisplay (reloj, reinicio, resultadoBCD, banderaConvertida, sieteSegmentosA, sieteSegmentosB, sieteSegmentosC);
	input reloj;
	input reinicio;
	input[11:0] resultadoBCD;
	input banderaConvertida;
	output[6:0] sieteSegmentosA;
	output[6:0] sieteSegmentosB;
	output[6:0] sieteSegmentosC;
	
	always @(posedge reloj) begin
		if (reinicio == 1'b0) begin
			if (banderaConvertida == 1'b1) begin
				case (resultadoBCD[3:0]) 
					4'b0000: sieteSegmentosA = 7'b1111111; //0
					4'b0001: sieteSegmentosA = 7'b1001111; //1
					4'b0010: sieteSegmentosA = 7'b0010010; //2
					4'b0011: sieteSegmentosA = 7'b0000110; //3
					4'b0100: sieteSegmentosA = 7'b1001100; //4
					4'b0101: sieteSegmentosA = 7'b0100100; //5
					4'b0110: sieteSegmentosA = 7'b0100000; //6
					4'b0111: sieteSegmentosA = 7'b0001111; //7
					4'b1000: sieteSegmentosA = 7'b0000000; //8
					4'b1001: sieteSegmentosA = 7'b0001100; //9
				endcase
				case (resultadoBCD[7:4]) 
					4'b0000: sieteSegmentosB = 7'b1111111; //0
					4'b0001: sieteSegmentosB = 7'b1001111; //1
					4'b0010: sieteSegmentosB = 7'b0010010; //2
					4'b0011: sieteSegmentosB = 7'b0000110; //3
					4'b0100: sieteSegmentosB = 7'b1001100; //4
					4'b0101: sieteSegmentosB = 7'b0100100; //5
					4'b0110: sieteSegmentosB = 7'b0100000; //6
					4'b0111: sieteSegmentosB = 7'b0001111; //7
					4'b1000: sieteSegmentosB = 7'b0000000; //8
					4'b1001: sieteSegmentosB = 7'b0001100; //9
				endcase
				case (resultadoBCD[11:8])
					4'b0000: sieteSegmentosC = 7'b1111111; //0
					4'b0001: sieteSegmentosC = 7'b1001111; //1
					4'b0010: sieteSegmentosC = 7'b0010010; //2
					4'b0011: sieteSegmentosC = 7'b0000110; //3
					4'b0100: sieteSegmentosC = 7'b1001100; //4
					4'b0101: sieteSegmentosC = 7'b0100100; //5
					4'b0110: sieteSegmentosC = 7'b0100000; //6
					4'b0111: sieteSegmentosC = 7'b0001111; //7
					4'b1000: sieteSegmentosC = 7'b0000000; //8
					4'b1001: sieteSegmentosC = 7'b0001100; //9
				endcase
			end
			else begin
				sieteSegmentosA = 7'b1111111;
				sieteSegmentosB = 7'b1111111;
				sieteSegmentosC = 7'b1111111;
			end
		end
		else begin
			sieteSegmentosA = 7'b1111111;
			sieteSegmentosB = 7'b1111111;
			sieteSegmentosC = 7'b1111111;
		end
	end
endmodule 