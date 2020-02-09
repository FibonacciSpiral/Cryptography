/*
This function will take the plaintext we want to encrypt and the two subkeys 
created by the key generation modules and it will create the ciphertext.
Again, endianess depends on how you enter your data. This algorithm operates
in the same way as the instructions. It takes whatever you give it. The left most
4 bits of your input will be treated as the left most 4 in the algorithm.
*/
module Encrypt(

	input [7:0] PlainText,
	input [7:0] subKey1,
	input [7:0] subKey2,
	output [7:0] CipherText

);

wire [7:0] IP_out;

IP_Function m1(PlainText, IP_out); //scrambles order

wire [7:0] FK1_out;

FK_operation m2(IP_out, subKey1, FK1_out); //implements Fk operation

wire [7:0] SWAP_result;

SWAP m3(FK1_out, SWAP_result); //Result of Fk is swapped

wire [7:0] FK2_out;

FK_operation m4(SWAP_result, subKey2, FK2_out); //Fk is done again with a different key

IP_Inverse m5(FK2_out, CipherText); //Apply Ip_Inverse and the result is ciphertext

endmodule
