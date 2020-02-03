module Wrapper (

 

//           //////////// CLOCK //////////

//           input                                               ADC_CLK_10,

//             input                                               CLOCK_50,

//           input                                               MAX10_CLK2_50,

//

//           //////////// SEG7 //////////

//           output                     [7:0]               HEX0,

//           output                     [7:0]               HEX1,

//           output                     [7:0]               HEX2,

//           output                     [7:0]               HEX3,

//           output                     [7:0]               HEX4,

//           output                     [7:0]               HEX5,

//

//           //////////// KEY //////////

//              input                        [3:0]               KEY,

//

//           //////////// LED //////////

              output                       [7:0]            	LEDR,

//

//           //////////// SW //////////

              input                        [7:0]               SW

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

wire [7:0] Byte;

assign Byte = 8'b01010101;

//XOR_Nibble assignment(SW[7:4], SW[3:0], LEDR[3:0]);

XOR_Byte assignment(Byte, SW[7:0], LEDR[7:0]);



endmodule