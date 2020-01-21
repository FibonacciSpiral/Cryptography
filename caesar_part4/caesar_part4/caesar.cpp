#include "caesar.h"

// This is the list of filenames for translation output files
std::string output_filenames[26] = { "plaintext/a.txt", "plaintext/b.txt", "plaintext/c.txt", "plaintext/d.txt", "plaintext/e.txt", "plaintext/f.txt",
									"plaintext/g.txt", "plaintext/h.txt", "plaintext/i.txt", "plaintext/j.txt", "plaintext/k.txt", "plaintext/l.txt",
									"plaintext/m.txt", "plaintext/n.txt", "plaintext/o.txt", "plaintext/p.txt", "plaintext/q.txt", "plaintext/r.txt",
									"plaintext/s.txt", "plaintext/t.txt", "plaintext/u.txt", "plaintext/v.txt", "plaintext/w.txt", "plaintext/x.txt",
									"plaintext/y.txt", "plaintext/z.txt" };

// will hold the scores for each translated file
int file_scores[26] = {};

// holds the value of each character as relating to its frequency
// in the English language starting from least frequent
char frequency_table[26] = { 'Z', 'J', 'Q', 'X', 'K', 'V', 'B', 'P', 'G',
							'W', 'Y', 'F', 'M', 'C', 'U', 'L', 'D', 'H',
							'R', 'S', 'N', 'I', 'O', 'A', 'T', 'E' };

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
			caesar_decipher(loop, input_file, output_file);
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
	char decrypted_char;

	while (!file_in.eof() && char_count < MAX_CHARS)	// loop till either eof or char limit is reached
	{
		std::getline(file_in, input);			// retrieve a line from the input file
		for (auto current_char = 0; current_char < input.size(); ++current_char)
		{
			if (char_count < MAX_CHARS)					// second char limit check necessary to avoid infinite length line in a file
			{
				decrypted_char = decrypt_char(input[current_char], key);
				output += decrypted_char;
				file_scores[key] += score(decrypted_char);
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
	if (!is_alpha(ciphertext))					// if the character is non-alphabetic, return the character
		return ciphertext;

	const bool uppercase = is_upper(ciphertext);

	uppercase ? ciphertext -= ASCII_UPPER_A : ciphertext -= ASCII_LOWER_A;		// convert from ascii to int value
	int plaintext = (ciphertext - key + 26) % 26;								// use the formula
	uppercase ? plaintext += ASCII_UPPER_A : plaintext += ASCII_LOWER_A;		// convert back from int to ascii value
	return char(plaintext);
}

int score(char input_char)
{
	input_char = toupper(input_char);		// convert to upper for convenience
	if (!is_alpha(input_char))				// if non-alphabetic, return 0
		return 0;
	else
	{
		// loop until the proper character is found
		// return the value of the loop + 1
		for (int value = 0; value < 26; ++value)
		{
			if (input_char == frequency_table[value])
				return ++value;
		}
	}
	exit(3);							// if this point is reached, something is wrong. exit code 3.
}

void crack(std::ifstream & input_file)
{
	split(input_file);
	//for (auto current_score = 0; current_score < 26; ++current_score)
	//	std::cout << "<Key, score> = " << current_score << ", " << file_scores[current_score] << '\n';

	int high_score = 0;
	int high_score_file = 0;

	for (auto current_score_file = 0; current_score_file < 26; ++current_score_file)
	{
		if (file_scores[current_score_file] > high_score)				// Looping through to find the highest scored file
		{
			high_score_file = current_score_file;
			high_score = file_scores[current_score_file];
		}
	}

	std::cout << "Translation complete.\nMost likely key was " << char(ASCII_UPPER_A + high_score_file) << '\n' << std::endl;
	// Gonna output the assumed correct translation
	std::ifstream decipher(output_filenames[high_score_file]);
	if (decipher.is_open())
	{
		std::string output;
		while (std::getline(decipher, output))
			std::cout << output << std::endl;
		decipher.close();
	}
	else
	{
		std::cout << "Bad file or filename. Exiting..." << std::endl;
		exit(4);													// This shouldn't happen
	}
}

bool is_alpha(char c)
{
	return ((int(c) >= ASCII_UPPER_A && int(c) <= ASCII_UPPER_Z) || (int(c) >= ASCII_LOWER_A && int(c) <= ASCII_LOWER_Z));
}

bool is_upper(char c)
{
	return (int(c) >= ASCII_UPPER_A && int(c) <= ASCII_UPPER_Z);
}
