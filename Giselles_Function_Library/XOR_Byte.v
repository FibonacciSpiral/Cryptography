//This module is an XOR that takes 2 bytes as inputs,
//XORs them together, and then outputs the result in Byte_Out
module XOR_Byte( 
	
	input [7:0] Byte_In_Left,
	input [7:0] Byte_In_Right,
	output [7:0] Byte_Out
	
);

assign Byte_Out = (Byte_In_Left & ~Byte_In_Right) | (~Byte_In_Left & Byte_In_Right);

endmodule