/*
This is the FK function. It takes an input byte, a key (which will be one of the subkeys),
and the output of the function is tied to the 8 bit bus Fkout.
Fk(L,R) = (L xor F(R, SK), R)
If you're concerned about endianess, all you have to do is be consistent within the 
module you're working on. Like if you want to enter your plaintext as 11001010 then just
enter that number as the plain text, how you see it here 11001010. It doesn't matter which
direction your databus is arranged in (for example [0:7] or [7:0], as long as you are 
consistent within the module.
*/

module FK_operation(

	input [0:7] inputByte,
	input [0:7] Key,
	output [0:7] Fkout

);

//first operation is EP. It takes the rightmost nibble and permutes/expands it

wire [0:7] EPoutput;

EP_Operation A (inputByte[4:7], EPoutput);

//Next the result of EP is xored with the key

wire [0:7] XOR_output;

XOR_Byte B (EPoutput, Key, XOR_output);

//Next, half the result is fed into s0 and the other half goes into s1

wire [0:3] Sboxout;

S0 C (XOR_output[0:3], Sboxout[0:1]);

S1 D (XOR_output[4:7], Sboxout[2:3]);

//The output is a 4 bit bus

//finally p4 shuffles the 4bit bus around and that is the result

wire [0:3] P4out;

P4_Operation E (Sboxout[0:3], P4out);

wire [0:3] nibbleout;

XOR_Nibble F (P4out, inputByte[0:3], nibbleout);

assign Fkout = {nibbleout, inputByte[4:7]};


endmodule
