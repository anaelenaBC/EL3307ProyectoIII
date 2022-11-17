module subsistemaLectura (reloj, reinicio, 
									operandoEntradaA, operandoEntradaB, iniciarMultiplicacion, 
									operandoSalidaA, operandoSalidaB, 
									ledOperandoA, ledOperandoB, banderaValida);
	input reloj;
	input reinicio;
	input[3:0] operandoEntradaA;
	input[3:0] operandoEntradaB;
	input iniciarMultiplicacion;
	output[3:0] operandoSalidaA;
	output[3:0] operandoSalidaB;
	output ledOperandoA;
	output ledOperandoB;
	output banderaValida;
		
	always @(posedge reloj) begin
		if (reinicio == 1'b0) begin
			operandoSalidaA = operandoEntradaA;
			operandoSalidaB = operandoEntradaB;
			ledOperandoA = 1'b0;
			ledOperandoB = 1'b0;
			banderaValida = 1'b1;
		end
		else begin
			operandoSalidaA = 4'b0000;
			operandoSalidaB = 4'b0000;
			ledOperandoA = 1'b1;
			ledOperandoB = 1'b1;
			banderaValida = 1'b0;
		end
	end
endmodule 