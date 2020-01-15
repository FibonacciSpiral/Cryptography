#include <iostream>		// Standard cout cin necessities
#include <fstream>		// Needed for file IO
#include <string>		// Working with strings in each file

#define ASCII_UPPER_A 65
#define ASCII_UPPER_Z 90
#define ASCII_LOWER_A 97
#define ASCII_LOWER_Z 122

using std::cout;
using std::cin;
using std::string;

// NOTE
// A-Z: 65-90
// a-z: 97-122

string caesar(bool encrypt, int key, std::fstream *fileIn, std::fstream *fileOut);
char encryptChar(char plaintext, int key);
char decryptChar(char ciphertext, int key);

int main()
{

	/*
	First part:
	- Gather data from user
	- Lots of ASCII stuff initially, but we'll convert it to numbers to deal with encrypt/decrypt
	*/

	char ckey;				// holds the key as an ASCII character
	int encrypt,			// encrypt tracks whether we are encrypting or decrypting
		key;				// key stores the working caesar cipher key						
	string fileName;		// holds the filenames for input and output
	std::fstream fileIn,	// fstream for the input file
		fileOut;			// fstream for the output file

	cout << "-------- CAESAR CIPHER --------\n\n";
	cout << "Enter 0 for decryption or 1 for encryption: ";
	cin >> encrypt;								// Big Problems if the input is any combination of non-numeric characters.
												// We probably don't have to worry about it because that's out of scope.
	while (encrypt != 1 && encrypt != 0) {		// Checking to see that the input was valid
		cout << "Invalid, try again: ";
		cin >> encrypt;
	}
	cout << "Enter input filename: ";
	cin >> fileName;							// using fileName as a temporary variable to hold the names of files to be opened
	fileIn.open(fileName);
	cout << "Enter output filename: ";
	cin >> fileName;
	fileOut.open(fileName);
	if (fileIn.fail() || fileOut.fail()) {		// Check that the files are valid and exit if EITHER is bad
		cout << "Bad file or filename. Exiting..." << std::endl;
		return 1;
	}
	cout << "Enter key: ";
	cin >> ckey;
	ckey = toupper(ckey);						// Converting to capital for consistent math
	key = ckey - ASCII_UPPER_A;					// Brings the original ASCII char value to a 0-25 integer scale
	while (key < 0 || key > 25) {				// Check if the character is alphabetic, if not, get new input
		cout << "Invalid, try again: ";
		cin >> ckey;
		ckey = toupper(ckey);
		key = ckey - ASCII_UPPER_A;
	}

	//cout << caesar(encrypt, key, &fileIn, &fileOut);
}

/*
	caesar()

	This function will take the direction of encryption, the key, and the filestreams
	for both input and output and perform the single-directional encryption or
	decryption. Special characters (numeric, symbolic, and spaces) will be included in
	the output file but will be omitted from Caesar modification.
*/
string caesar(bool encrypt, int key, std::fstream *fileIn, std::fstream *fileOut)
{
	// Keeping this code commented for testing purposes
	/*cout << "Currently stored values\n";
	cout << "encrypt = " << int(encrypt) << std::endl;
	cout << "key = " << key << std::endl;
	if (fileIn->is_open())
		cout << "fileIn is open\n";
	else
		cout << "fileIn is not open\n";
	if (fileOut->is_open())
		cout << "fileOut is open\n";
	else
		cout << "fileOut is not open\n";*/



	return "Success\n";
}

/*
	encryptChar()

	This function will take a single character and the numeric key as input and return
	the Caesar encrypted character. Applying the formula that Phong gave us during
	lecture.

	Cipher = (Plaintext + Key) mod 26
*/
char encryptChar(char plaintext, int key)
{
	return((plaintext + key) % 26);		// hey it looks just like the formula :O
}

/*
	decryptChar()

	This function takes a single ciphertext character and the numeric key as params
	and returns the Caesar decrypted character. Applying the formula that Phong gave
	us during lecture.

	Plaintext = (Cipher – Key + 26) mod 26
*/
char decryptChar(char ciphertext, int key)
{
	return((ciphertext - key + 26) % 26);
}

// TODO
// Function for caesar
// - Add for encrypt, subtract for decrypt