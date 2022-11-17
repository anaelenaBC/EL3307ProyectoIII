module proyecto3 (reloj, reinicio, operandoA, operandoB, iniciarMultiplicacion, ledOperandoA, ledOperandoB, sieteSegmentosA, sieteSegmentosB, sieteSegmentosC);
	input reloj;
	input reinicio;
	input[3:0] operandoA;
	input[3:0] operandoB;
	input iniciarMultiplicacion;
	
	output ledOperandoA;
	output ledOperandoB;
	output[6:0] sieteSegmentosA;
	output[6:0] sieteSegmentosB;
	output[6:0] sieteSegmentosC;

	wire[3:0] wireOperandoA;
	wire[3:0] wireOperandoB;
	wire wireBanderaValida;
	
	wire[7:0] wireResultadoBinario;
	wire wireBanderaLista;
	
	wire[11:0] wireResultadoBCD;
	wire banderaConvertida;
	
	subsistemaLectura instanciaSubsistemaLectura(.reloj(reloj), 
																.reinicio(reinicio),
																.operandoEntradaA(operandoA),
																.operandoEntradaB(operandoB),
																.iniciarMultiplicacion(iniciarMultiplicacion),
																.operandoSalidaA(wireOperandoA),
																.operandoSalidaB(wireOperandoB),
																.ledOperandoA(ledOperandoA),
																.ledOperandoB(ledOperandoB),
																.banderaValida(wireBanderaValida));
	
	subsistemaMultiplicacion instanciaSubsistemaMultiplicacion(.reloj(reloj),
																				  .reinicio(reinicio),
																				  .operandoA(wireOperandoA),
																				  .operandoB(wireOperandoB),
																				  .banderaValida(wireBanderaLista),
																				  .resultado(wireResultadoBinario),
																				  .banderaLista(wireBanderaLista));
	
	subsistemaConversion instanciaSubsistemaConversion(.reloj(reloj),
																		.reinicio(reinicio),
																		.resultadoEntrada(wireResultadoBinario),
																		.banderaLista(wireBanderaLista),
																		.bcd(wireResultadoBCD),
																		.banderaConvertida(wireBanderaConvertida));
	
	subsistemaDisplay instanciaSubsistemaDisplay(.reloj(reloj),
																.reinicio(reinicio),
																.resultadoBCD(wireResultadoBCD),
																.banderaConvertida(wireBanderaConvertida),
																.sieteSegmentosA(sieteSegmentosA),
																.sieteSegmentosB(sieteSegmentosB),
																.sieteSegmentosC(sieteSegmentosC));

endmodule 