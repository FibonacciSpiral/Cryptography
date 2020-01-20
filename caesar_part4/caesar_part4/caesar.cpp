#include "caesar.h"

// This is the list of filenames for translation output files
std::string output_filenames[26] = { "plaintext/a.txt", "plaintext/b.txt", "plaintext/c.txt", "plaintext/d.txt", "plaintext/e.txt", "plaintext/f.txt",
									"plaintext/g.txt", "plaintext/h.txt", "plaintext/i.txt", "plaintext/j.txt", "plaintext/k.txt", "plaintext/l.txt",
									"plaintext/m.txt", "plaintext/n.txt", "plaintext/o.txt", "plaintext/p.txt", "plaintext/q.txt", "plaintext/r.txt",
									"plaintext/s.txt", "plaintext/t.txt", "plaintext/u.txt", "plaintext/v.txt", "plaintext/w.txt", "plaintext/x.txt",
									"plaintext/y.txt", "plaintext/z.txt" };

void split(std::ifstream & input_file)
{
	std::ofstream output;
	std::string buffer;
	for (auto loop = 0; loop < 26; ++loop)
	{
		output.open(output_filenames[loop]);	// first, open the output file, looping through 26 output files
		if (output.is_open())
		{
			output << "test";
		}
		else								// if file was bad, we'll exit with code 2
		{
			std::cout << "Bad file or filename. Exiting..." << std::endl;
			exit(2);
		}
		output.close();						// make sure the current file is closed
	}
}
