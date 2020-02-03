/*
This function takes whatever byte you enter
(1, 2, 3, 4, 5, 6, 7, 8)

and scrambles it to

(2, 6, 3, 1, 4, 8, 5, 7)

*/

module IP_Function(

	input [0:7] Plaintext,
	output [0:7] Scrabble	//scrabble is a cute name for the scrambled text
	
);



assign Scrabble = { Plaintext[1], Plaintext[5], Plaintext[2], Plaintext[0], 
						  Plaintext[3], Plaintext[7], Plaintext[4], Plaintext[6]};

endmodule