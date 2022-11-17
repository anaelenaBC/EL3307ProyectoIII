module subsistemaConversion (reloj, reinicio, resultadoEntrada, banderaLista, bcd, banderaConvertida);
	input reloj;
	input reinicio;
	input[7:0] resultadoEntrada;
	input banderaLista;
	output[12:0] bcd;
	output banderaConvertida;
	
	reg[11:0] bcd;
	reg[3:0] i;   
     
	always @(posedge reloj) begin
		if (reinicio == 1'b0) begin
			if (banderaLista == 1'b1) begin
				bcd = 0;
				for (i = 0; i < 8; i = i+1) begin
					bcd = {bcd[10:0], resultadoEntrada[7-i]};
					if(i < 7 && bcd[3:0] > 4) begin
						bcd[3:0] = bcd[3:0] + 3;
					end
					if(i < 7 && bcd[7:4] > 4) begin
					  bcd[7:4] = bcd[7:4] + 3;
					end
					if(i < 7 && bcd[11:8] > 4) begin
					  bcd[11:8] = bcd[11:8] + 3;
					end
				end
				banderaConvertida = 1'b1;
			end
			else begin
				bcd = 12'b000000000000;
				banderaConvertida = 1'b0;
			end
		end
		else begin
			bcd = 12'b000000000000;
			banderaConvertida = 1'b0;
		end
	end
	
endmodule 