/*
This is the expansion/permutation function in Fk module.
Basically, it takes the rightmost 4 bits of the byte you're
working with and expands it to 8 bits. It also scrambles the
data a little bit to help make the algorithm more complex.

nibble (1, 2, 3, 4) becomes
byte (4, 1, 2, 3, 2, 3, 4, 1)
*/

module EP_Operation(

	input [0:3] RightMost, //Rightmost refers to 'R' in Fk(L,R)
	output [0:7] outputByte //This output byte will be XOR'ed with the subkey
	
);

assign outputByte = { RightMost[3], RightMost[0], RightMost[1], RightMost[2],
							 RightMost[1], RightMost[2], RightMost[3], RightMost[0]};

endmodule
							 