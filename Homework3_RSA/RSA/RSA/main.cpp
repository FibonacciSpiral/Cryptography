#include <iostream>
#include "rsa.h"
#include <string>
using std::cout;
using std::cin;
using std::endl;
using std::string;

int main()
{
	vlint_t p = 83621, q = 33113, e1, e2, e3;
	vlint_t out1[5], out2[5], out3[5];

	cout << "RSA KEYGEN\n";
	cout << "p = " << p << " | q = " << q << "\n";
	cout << "Enter first e: ";
	cin >> e1;
	keygen(p, q, e1, out1);
	cout << "Enter second e: ";
	cin >> e2;
	keygen(p, q, e2, out2);
	cout << "Enter third e: ";
	cin >> e3;
	keygen(p, q, e3, out3);

	cout << endl;
	cout << "ROUND ONE\n";
	cout << "e = " << e1 << " | d = " << out1[4] << " | N = " << out1[3] << endl;
	cout << "ROUND TWO\n";
	cout << "e = " << e2 << " | d = " << out2[4] << " | N = " << out2[3] << endl;
	cout << "ROUND THREE\n";
	cout << "e = " << e3 << " | d = " << out3[4] << " | N = " << out3[3] << endl;

	int get;
	cin >> get;
	return 0;
}