#include "caesar.h"

// This is the list of filenames for translation output files
std::string output_filenames[26] = { "plaintext/a.txt", "plaintext/b.txt", "plaintext/c.txt", "plaintext/d.txt", "plaintext/e.txt", "plaintext/f.txt",
									"plaintext/g.txt", "plaintext/h.txt", "plaintext/i.txt", "plaintext/j.txt", "plaintext/k.txt", "plaintext/l.txt",
									"plaintext/m.txt", "plaintext/n.txt", "plaintext/o.txt", "plaintext/p.txt", "plaintext/q.txt", "plaintext/r.txt",
									"plaintext/s.txt", "plaintext/t.txt", "plaintext/u.txt", "plaintext/v.txt", "plaintext/w.txt", "plaintext/x.txt",
									"plaintext/y.txt", "plaintext/z.txt" };

/*
 * split()
 * 
 * This function takes an input filestream object and
 * performs 26 translations, one for each possible key,
 * and outputs the translations to separate files.
 */
void split(std::ifstream & input_file)
{
	std::ofstream output_file;
	std::string buffer;
	for (auto loop = 0; loop < 26; ++loop)
	{
		output_file.open(output_filenames[loop]);	// first, open the output file, looping through 26 output files
		if (output_file.is_open())					// decipher the input file for each possible key
			caesar_decipher(loop+1, input_file, output_file);
		else										// if file was bad, we'll exit with code 2
		{
			std::cout << "Bad file or filename. Exiting..." << std::endl;
			exit(2);
		}
		output_file.close();						// make sure the current file is closed
		input_file.seekg(0);						// seek back to the beginning of the file
	}
}

/*
 * caesar_decipher()
 * 
 * Takes a key, an input filestream, and an output filestream as parameters,
 * performing a Caesar decipher on the input filestream and directing to the
 * output filestream.
 */
void caesar_decipher(const int key, std::ifstream& file_in, std::ofstream& file_out)
{
	std::string input,							// this string will hold the working line in the input file
				output;							// holds the output to be routed to the output file
	auto char_count = 0;							// we're limiting number of characters to 500 so we need something to track that

	while (!file_in.eof() && char_count < MAX_CHARS)	// loop till either eof or char limit is reached
	{
		std::getline(file_in, input);			// retrieve a line from the input file
		for (auto current_char = 0; current_char < input.size(); ++current_char)
		{
			if (char_count < MAX_CHARS)					// second char limit check necessary to avoid infinite length line in a file
			{
				output += decrypt_char(input[current_char], key);
				++char_count;
			}
		}
	}
	file_out << output;
}

/*
 * decrypt_char()
 * 
 * deciphers a single character using the Caesar algorithm.
 */
char decrypt_char(char ciphertext, const int key)
{
	if (!isalpha(ciphertext))					// if the character is non-alphabetic, return the character
		return ciphertext;

	const bool uppercase = isupper(ciphertext);

	uppercase ? ciphertext -= ASCII_UPPER_A : ciphertext -= ASCII_LOWER_A;		// convert from ascii to int value
	int plaintext = (ciphertext - key + 26) % 26;								// use the formula
	uppercase ? plaintext += ASCII_UPPER_A : plaintext += ASCII_LOWER_A;		// convert back from int to ascii value
	return char(plaintext);
}