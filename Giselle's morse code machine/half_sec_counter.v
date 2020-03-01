module half_sec_counter( //This is a half second counter that determines the timing for the morse code machine

	input CLOCK_50,
	input ENABLE,		//enables half second counter
	input wire [24:0] Period, //This number determines the period. 25 million makes a half second timer
	output reg [2:0] half_sec_count //holds the half_sec_count 
	
);
	
reg Clock_Flag;	//This is a half second clock

//half second counter, keeps track of half second intervals

reg [24:0] Time_Reg; //can hold about 33 million, we need 25 million ticks to make one half second

always@(posedge CLOCK_50)
begin 
if (ENABLE) begin
		if (Time_Reg > (Period/2))
			begin 						 //We count half seconds by looking at posedge, so that puts it where it needs to be
				Time_Reg = 0;
				Clock_Flag = ~Clock_Flag; //Clock_Flag toggle			
			end
		else Time_Reg = Time_Reg + 25'd1;
	end
else begin Time_Reg = 0; Clock_Flag = 0; end
end

	
always@(negedge Clock_Flag or negedge ENABLE)
begin
		if(~ENABLE) begin
			half_sec_count = 0;
			end
		else half_sec_count = half_sec_count + 3'd1;
		
end
	
	
endmodule
