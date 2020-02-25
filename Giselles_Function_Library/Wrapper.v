module Wrapper (

 

//           //////////// CLOCK //////////

//           input                                               ADC_CLK_10,

//             input                                               CLOCK_50,

//           input                                               MAX10_CLK2_50,

//

//           //////////// SEG7 //////////

           output                     [7:0]               HEX0,

           output                     [7:0]               HEX1,

           output                     [7:0]               HEX2,

           output                     [7:0]               HEX3,

           output                     [7:0]               HEX4,

           output                     [7:0]               HEX5,

//

//           //////////// KEY //////////

              input                        [3:0]               KEY,

//

//           //////////// LED //////////

              output                       [9:0]            	LEDR,

//

//           //////////// SW //////////

              input                        [9:0]               SW

//

//           //////////// VGA //////////

//           output                     [3:0]               VGA_B,

//           output                     [3:0]               VGA_G,

//           output                                            VGA_HS,

//           output                     [3:0]               VGA_R,

//           output                                            VGA_VS,

//

//           //////////// Arduino //////////

//           inout                       [15:0]                            ARDUINO_IO,

//           inout                                               ARDUINO_RESET_N,

//

//           //////////// GPIO, GPIO connect to GPIO Default //////////

//           inout                       [35:0]                            GPIO
);


wire [7:0] subkey1;

wire [7:0] subkey2;

decoder_7_seg assignment1 (resultreg2[3:0], HEX0[7:0]);
decoder_7_seg assignment2 (resultreg2[7:4], HEX1[7:0]);
decoder_7_seg assignment3 (resultreg1[3:0], HEX2[7:0]);
decoder_7_seg assignment4 (resultreg1[7:4], HEX3[7:0]);
decoder_7_seg assignment5 (MessageReg[3:0], HEX4[7:0]);
decoder_7_seg assignment6 (MessageReg[7:4], HEX5[7:0]);

reg [9:0] key10 = 0;

wire reset;

assign reset = ~KEY[2];

always@(posedge KEY[0] or posedge reset) begin //load 10 bit key into register
	
	if(reset)
		key10 = 10'b0000000000;
	else
		key10 = SW[9:0];
	
end

assign LEDR[9:0] = key10;

reg [7:0] resultreg1 = 0;

reg [7:0] resultreg2 = 0;

reg [7:0] result = 0; //this is loaded with the result of encrypt or decrypt

always@(posedge KEY[1] or posedge reset) begin // displays result or the subkeys depending on SW[0]

	if(reset) begin
		result = 8'b00000000;
		resultreg2 = 8'b00000000;
		resultreg1 = 8'b00000000;
	end
	else begin
		if (SW[1]) //We are encrypting message
			result = EncryptReg;
		else
			result = DecryptReg;

		if (SW[0]) begin
			resultreg2 = result;
			resultreg1 = 8'b00000000;
		end
		else begin
			resultreg1 = subkey1;
			resultreg2 = subkey2;
		end
	
	end

end


reg [7:0] MessageReg = 0;

always@(posedge KEY[3] or posedge reset) begin //loads message into message register

	if(reset)
		MessageReg = 8'b00000000;
	else
		MessageReg = SW[7:0];

end


key_gen instance1({ key10[0], key10[1], key10[2], key10[3], key10[4], key10[5], 
						  key10[6], key10[7], key10[8], key10[9] }, subkey1, subkey2);
						  
wire [7:0] EncryptReg;

wire [7:0] DecryptReg;


Encrypt assignment(MessageReg, subkey1, subkey2, EncryptReg);

Decrypt instance2(MessageReg, subkey1, subkey2, DecryptReg);


endmodule