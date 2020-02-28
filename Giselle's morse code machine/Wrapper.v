module Wrapper (

 

//           //////////// CLOCK //////////

//           input                                               ADC_CLK_10,

             input                                               CLOCK_50,

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

              input                        [3:0]               KEY,

//

//           //////////// LED //////////

              output                       [9:0]            	LEDR,

//

//           //////////// SW //////////

              input                        [4:0]               SW

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

//wire [24:0] period = 25'd25000000;

//parameter Period = 25'd25000000;

//wire shift;
//
//assign shift = ~KEY[0];
//
//wire start;
//
//assign start = ~KEY[1];
//
//wire [3:0] Pattern;
//
//wire [3:0] length;
// 
// 
////half_sec_counter instance1(CLOCK_50, SW[0], Period, LEDR[7:0], LEDR[9]);
//
//PatternMux instance2(SW[2:0], Pattern, length);
//
//ShiftRegister instance3(shift, start, Pattern, LEDR[2:0], LEDR[9:8]);

MorseCodeTA assignment (KEY[3], KEY[2], CLOCK_50, SW[4:0], LEDR[0]);
endmodule