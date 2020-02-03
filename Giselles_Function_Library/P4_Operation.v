/*
This is the P4 operation that is used in the F function 
(which is inside of Fk). It takes the output from the matrices,
and scrambles it.

nibble (1, 2, 3, 4) becomes
nibble (2, 4, 3, 1)
*/

module P4_Operation(

	input [0:3] inputNibble,
	output [0:3] outputNibble
	
);

assign outputNibble = { inputNibble[1], inputNibble[3], inputNibble[2], inputNibble[0] };

endmodule
