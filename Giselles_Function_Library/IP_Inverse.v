/*
This function takes whatever byte you enter
(1, 2, 3, 4, 5, 6, 7, 8)

and scrambles it to

(4, 1, 3, 5, 7, 2, 8, 6)

This function will actually undo any scrambling done by the regular IP_Function

*/
module IP_Inverse(

	input [0:7] inputText,	
	output [0:7] outputText
	
);



assign outputText = { inputText[3], inputText[0], inputText[2], inputText[4],
							 inputText[6], inputText[1], inputText[7], inputText[5]};

endmodule