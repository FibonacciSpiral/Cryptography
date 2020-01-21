/*
 * Caesar Codebreaker
 * 
 * This program will take a single user input consisting of a filename
 * for a Caesar ciphered file and result in a single most-likely
 * translation output file.
 */

#include <iostream>
#include <fstream>
#include <string>
#include "caesar.h"

using std::cout;
using std::cin;
using std::string;

void get_input_filename(std::ifstream& file);

int main()
{
	// first need to obtain filename input from user
	std::ifstream input_file;
	get_input_filename(input_file);
	if (input_file.is_open())
		cout << "Success" << std::endl;
	crack(input_file);

	input_file.close();		// remember to close the filestream
	return 0;
}

/*
 * get_input_filename()
 * 
 * Retrieves a filename from the user and attempts to open the file, 
 * exiting the program if opening the file failed.
 */
void get_input_filename(std::ifstream& file)
{
	string filename;
	cout << "Please enter an input filename (include file extension): ";
	getline(cin, filename);
	file.open(filename);
	if (file.fail())
	{
		cout << "Bad file or filename. Exiting..." << std::endl;
		exit(1);
	}
}