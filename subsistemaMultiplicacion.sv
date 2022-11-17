typedef struct {
	logic load_A;
	logic load_B;
	logic load_add;
	logic shift_HQ_LQ_Q_1;
	logic add_sub;
} mult_control_t;


module subsistemaMultiplicacion (reloj, reinicio, 
											operandoA, operandoB, banderaValida, 
											controladorMult, 
											resultado, banderaLista);
	input reloj;
	input reinicio;
	input[3:0] operandoA;
	input[3:0] operandoB;
	input banderaValida;
	input mult_control_t controladorMult;
	output[7:0] resultado;
	output banderaLista;
		
	logic[7:0] M;
	logic[7:0] adder_sub_out;
	logic[16:0] shift;
	logic[7:0] HQ;
	logic[7:0] LQ;
	logic Q_1;
	reg[2:0] qlsb;
	reg[3:0] A;
	reg[3:0] B;
	reg[7:0] Y;
	
	always_ff @(posedge reloj) begin
		if (reinicio == 1'b1) begin
			M <= 8'b00000000;
		end
		else begin
			if (controladorMult.load_A) begin
				M <= A;
			end
			else begin
				M <= M;
			end
		end
	end
	
	always_comb begin
		if (controladorMult.add_sub) begin
			adder_sub_out = M + HQ;
		end
		else begin
			adder_sub_out = M - HQ;
		end
	end
	
	always_comb begin
		Y = {HQ,LQ};
		HQ = shift[16:9];
		LQ = shift[8:1];
		Q_1 = shift[0];
		qlsb = {LQ[0], Q_1};
	end
	
	always_ff @(posedge reloj) begin
		if (reinicio == 1'b1) begin
			shift <= 'b0;
		end
		else if (controladorMult.shift_HQ_LQ_Q_1) begin
			shift <= $signed(shift)>>>1;
		end
		else begin
			if (controladorMult.load_B) begin
				shift[8:1] <= B;
			end
			if (controladorMult.load_add) begin
				shift[16:9] <= adder_sub_out;
			end
		end
	end
	
	always @(posedge reloj) begin
		if (reinicio == 1'b0) begin
			if (banderaValida == 1'b1) begin
				resultado = operandoA*operandoB;
				banderaLista = 1'b1;
			end
			else begin
				resultado = 8'b00000000;
				banderaLista = 1'b0;
			end
		end
		else begin
			resultado = 8'b00000000;
			banderaLista = 1'b0;
		end
	end

endmodule 