module ShiftRegister(

	input SHIFT, 						//signal telling the SR when to shift to the next dot or dash
	input Start,						//Start button
	input wire [3:0] PATTERN,		//uses the selected pattern from the PatternMux
	output reg [2:0] shift_count, //keeps track of the number of shifts that have occured
	output reg [1:0] SR_output     //output of the shift register, either a dot or dash
	
);


reg [3:0] DataReg = 0;

parameter idle = 2'b00, dot = 2'b01, dash = 2'b10, pause = 2'b11;

always@(posedge SHIFT or posedge Start) begin

		if (Start) begin
			DataReg <= PATTERN; 
			shift_count <= 0;
		end
		else if (SHIFT) begin
			DataReg[3] <= 1'bx;
			DataReg[2] <= DataReg[3];
			DataReg[1] <= DataReg[2];
			DataReg[0] <= DataReg[1]; //data is shifting to the right pushing in the pattern
			
			shift_count <= shift_count + 3'b1;
			
		end
		else DataReg <= 0;
		
		case (DataReg[0])
			0: SR_output <= dot; 
			
			1: SR_output <= dash; 
				
			default: begin SR_output <= idle; 
		 end
		endcase
	 
end		
		


endmodule
