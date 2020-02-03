/*
Left-most nibble becomes rightmost nibble
right-most nibble becomes leftmost nibble
*/

module SWAP(

	input [0:7] inputByte,
	output [0:7] outputByte
	
);

assign outputByte = { inputByte[4:7], inputByte[0:3] };

endmodule
