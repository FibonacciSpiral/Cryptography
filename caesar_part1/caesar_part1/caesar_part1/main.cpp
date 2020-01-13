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
	cin >> encrypt;			// Big Problems if the input is any combination of non-numeric characters.
							// We probably don't have to worry about it because that's out of scope.
	while (encrypt != 1 && encrypt != 0) {		// Checking to see that the input was valid
		cout << "Invalid, try again: ";
		cin >> encrypt;
	}
	cout << "Enter input filename: ";
	cin >> fileName;
	fileIn.open(fileName);
	cout << "Enter output filename: ";
	cin >> fileName;
	fileOut.open(fileName);
	if (fileIn.fail() || fileOut.fail()) {		// Check that the files are valid and exit if bad
		cout << "Bad file or filename. Exiting..." << std::endl;
		return 1;
	}
	cout << "Enter key: ";
	cin >> ckey;
	ckey = toupper(ckey);		// Converting to capital for consistent math
	key = ckey - ASCII_UPPER_A;
	while (key < 0 || key > 25) {
		cout << "Invalid, try again: ";
		cin >> ckey;
		ckey = toupper(ckey);
		key = ckey - ASCII_UPPER_A;
	}

	cout << caesar(encrypt, key, &fileIn, &fileOut);
}

string caesar(bool encrypt, int key, std::fstream *fileIn, std::fstream *fileOut)
{
	cout << "Currently stored values\n";
	cout << "encrypt = " << int(encrypt) << std::endl;
	cout << "key = " << key << std::endl;
	if (fileIn->is_open())
		cout << "fileIn is open\n";
	else
		cout << "fileIn is not open\n";
	if (fileOut->is_open())
		cout << "fileOut is open\n";
	else
		cout << "fileOut is not open\n";
	return "Success\n";
}

// TODO
// Function for caesar
// - Add for encrypt, subtract for decrypt
// - boolean for decryption
// - strings for file names
// - convert key to int