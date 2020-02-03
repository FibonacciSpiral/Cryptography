//This is a simple XOR that takes 2 nibbles(half bytes), XORS them,
//and returns the result in Nibble_Out

module XOR_Nibble( 
	
	input [3:0] Nibble_In_Left,
	input [3:0] Nibble_In_Right,
	output [3:0] Nibble_Out
	
);

assign Nibble_Out = (Nibble_In_Left & ~Nibble_In_Right) | (~Nibble_In_Left & Nibble_In_Right);

endmodule