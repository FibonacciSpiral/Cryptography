module MorseCodeTA( //This is the control module. Instantiate this to use the morse code machine, example in wrapper file

	input CLK, //starts the counting sequence
	input RESET, //resets the machine
	input CLOCK_50,
	input [4:0] SW, //specifies which letter to output
	output reg LIGHT //blinks according to letter that was selected
	
);
wire CLK_inv;

wire RESET_inv;

parameter Period = 25'd25000000; //number of ticks on 50MHz CLK that need to have passed in order to trigger counter

assign CLK_inv = ~CLK; //making active low lock into active high clock

assign RESET_inv = ~RESET;

wire [3:0] PATTERN; //represents the signal to output (alphabetical characters A-H)

wire [2:0] Length; //Tells state machine how many bits the letter is.

PatternMux Mux(SW, CLK_inv, RESET_inv, PATTERN, Length);

	
//shift register which feeds data into output logic


reg SHIFT = 0;


//Basically, the enable is what controls the half second counter

ShiftRegister SR(SHIFT, CLK_inv, PATTERN, shift_count, SR_output);

wire [2:0] shift_count;


reg ENABLE = 0; //This variable controls the half second counter

reg [2:0] Count = 0; // variable used to indicate how many half seconds we should use for one dot or dash

wire [2:0] half_sec_count; // variable to hold the half second count


half_sec_counter assignment(CLOCK_50, ENABLE, Period, half_sec_count);


reg [1:0] NextState = idle;

reg [1:0] currentState = idle;

parameter idle = 2'b00, dot = 2'b01, dash = 2'b10, pause = 2'b11;

always@(*) //current state logic
begin
	case (currentState)
		dot: begin Count = 3'd1; LIGHT = 1; end
		dash: begin Count = 3'd3; LIGHT = 1; end
		pause: begin Count = 3'd1; LIGHT = 0; end
		idle:	begin Count = 3'd0; LIGHT = 0; end
		default: begin Count = 3'd0; LIGHT = 1; end
	endcase
		
end

wire [1:0] SR_output;	


reg Done = 0;

always@(posedge CLOCK_50 or posedge RESET_inv) //control for shift and enable + next state logic
begin
	if (RESET_inv) begin
		NextState <= idle;
		SHIFT <= 0;
		ENABLE <= 0;
		Done <= 1;
		end
	else if ((currentState == dot) || (currentState == dash)) begin
		NextState <= pause;
		SHIFT <= 0;
		if (half_sec_count >= Count) begin //make done signal to tell when to move to next state.
			Done <= 1;
			ENABLE <= 0;
			end
		else begin
			ENABLE <= 1;
			Done <= 0;	
			end
		end
	else if (currentState == pause) begin
	
		SHIFT <= 1;
		
		if (shift_count >= Length)
			NextState <= idle;
		else NextState <= SR_output;
		
		if (half_sec_count >= Count)
			ENABLE <= 0;
		else ENABLE <= 1;
			
		if (ENABLE == 1)
			Done <= 0;
		else Done <= 1;
			
		end
	else if (currentState == idle) begin
		NextState <= idle;
		ENABLE <= 0;
		SHIFT <= 0;
		Done <= 0;
	end
	else begin //default state
		NextState <= idle;
		ENABLE <= 0;
		SHIFT <= 0;
		Done <= 0;
	end
	
end

always@(posedge Done or posedge CLK_inv)
begin

	if (CLK_inv)
		currentState = SR_output;
	else if (Done)
		currentState = NextState;
	else currentState = idle;
	
	
end
	


endmodule
	