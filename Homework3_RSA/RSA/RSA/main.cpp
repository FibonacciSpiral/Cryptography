#include <iostream>
#include "rsa.h"
#include <string>
using std::cout;
using std::cin;
using std::endl;
using std::string;

int main()
{
	char menu, cont = 'y';
	vlint_t in, N, result;

	cout << "RSA ENCRYPT/DECRYPT\n\n";

	while (cont == 'y')
	{
		cout << "Encrypt or decrypt? (e/d): ";
		cin >> menu;
		while (menu != 'e' && menu != 'd')
		{
			cout << "Invalid, enter again: ";
			cin >> menu;
		}

		if (menu == 'e')
		{
			vlint_t e;
			cout << "Enter plaintext number: ";
			cin >> in;
			cout << "Enter encryption key (e): ";
			cin >> e;
			cout << "Enter modulus (N): ";
			cin >> N;
			result = encrypt(in, e, N);
		}
		else
		{
			vlint_t d;
			cout << "Enter ciphertext number: ";
			cin >> in;
			cout << "Enter decryption key (d): ";
			cin >> d;
			cout << "Enter modulus (N): ";
			cin >> N;
			result = decrypt(in, d, N);
		}
		cout << "Outcome = " << result << endl;
		cout << "Enter 'y' to run again: ";
		cin >> cont;
	}

	int get;
	cin >> get;
	return 0;
}