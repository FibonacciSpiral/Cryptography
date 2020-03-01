module PatternMux( //This is a clocked multiplexer that determines the morse pattern and length

	input [4:0] letter,
	input start,
	input reset,
	output reg [3:0] PATTERN,
	output reg [2:0] Length //tells the shift register when to stop
	
);

parameter A = 5'b00000, B = 5'b00001, C = 5'b00010, D = 5'b00011, E = 5'b00100, F = 5'b00101, G = 5'b00110, H = 5'b00111,
			I = 5'b01000, J = 5'b01001, K = 5'b01010, L = 5'b01011, M = 5'b01100, N = 5'b01101, O = 5'b01110, P = 5'b01111, 
			Q = 5'b10000, R = 5'b10001, S = 5'b10010, T = 5'b10011, U = 5'b10100,  V = 5'b10101,  W= 5'b10110,  X= 5'b10111,  
			Y = 5'b11000, Z = 5'b11001;


always@(posedge start or posedge reset) //which pattern to feed into shift register
begin
		
		if (reset) begin
			PATTERN = 4'b0000;
			Length = 3'd0;
			end
		else begin
		
		case(letter[4:0])
		A: begin PATTERN = 4'bxx10; Length = 3'd2; end
	
		B: begin PATTERN = 4'b0001; Length = 3'd4; end
		
		C: begin PATTERN = 4'b0101; Length = 3'd4; end
		
		D: begin PATTERN = 4'bx001; Length = 3'd3; end
		
		E: begin PATTERN = 4'bxxx0; Length = 3'd1; end
		
		F: begin PATTERN = 4'b0100; Length = 3'd4; end
		
		G: begin PATTERN = 4'bx011; Length = 3'd3; end
	
		H: begin PATTERN = 4'b0000; Length = 3'd4; end
		
		I: begin PATTERN = 4'bXX00; Length = 3'd2; end
		
		J: begin PATTERN = 4'b1110; Length = 3'd4; end
		
		K: begin PATTERN = 4'bX101; Length = 3'd3; end
		
		L: begin PATTERN = 4'b0010; Length = 3'd4; end
		
		M: begin PATTERN = 4'bXX11; Length = 3'd2; end
		
		N: begin PATTERN = 4'bXX01; Length = 3'd2; end
		
		O: begin PATTERN = 4'b0111; Length = 3'd3; end
		
		P: begin PATTERN = 4'b0110; Length = 3'd4; end
		
		Q: begin PATTERN = 4'b1011; Length = 3'd4; end
		
		R: begin PATTERN = 4'bX010; Length = 3'd3; end
		
		S: begin PATTERN = 4'bX000; Length = 3'd3; end
		
		T: begin PATTERN = 4'bXXX1; Length = 3'd1; end
		
		U: begin PATTERN = 4'bX100; Length = 3'd3; end
		
		V: begin PATTERN = 4'b1000; Length = 3'd4; end
		
		W: begin PATTERN = 4'bX110; Length = 3'd3; end
		
		X: begin PATTERN = 4'b1001; Length = 3'd4; end
		
		Y: begin PATTERN = 4'b1101; Length = 3'd4; end
		
		Z: begin PATTERN = 4'b0011; Length = 3'd4; end
		
		default: begin PATTERN = 4'bxxxx; Length = 3'd0; end
			
		endcase
	end
end
	
endmodule