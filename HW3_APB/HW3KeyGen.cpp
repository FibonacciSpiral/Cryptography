// HW3.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
#include<iostream>
#include<stdio.h>
#include<conio.h>
#include<string.h>
#include<stdlib.h>
#include<assert.h>
#include<math.h>
typedef long long llt;   //llt is substitute for long long
using namespace std;

//
//int is_prime(llt num)
//{
//	llt i;
//	llt j = sqrt(num);
//	for (i = 2; i <= j; i++)
//	{
//		if (num % i == 0)
//			return 0;
//	}
//	return 1;
//}

llt simplified_eea_modInverse(llt a, llt b)
{
	//EEA finds gcd of a & b and x, y such that ax + by = gcd(a, b)
	//this function finds x and y such that ax + by = 1 because a and b are expected to be coprime i.e. gcd(a, b) = 1
	//we are interested only in x since it's the modulo inverse of a i.e. the RSA private key d for the given public key e = a and totient = b 

	llt orig_a = a;
	llt orig_b = b; //original b. needed to convert -ve x to +ve if x is caclulated as -ve
	
	//cout << "A: " << orig_a << ", B: " << origi_b << endl;

	llt y = 0, x = 1;

	if (b == 1)
		return 0;

	while (a > 1)   //loop until a was set as 1 in the previous loop i.e for gcd condition gcd(a,b) = 1
	{
		// prev_q is the quotient of previous a and b. a & b are updated later in this loop
		llt prev_q = a / b;
		llt prev_b = b;

		// b is remainder now, process same as 
		// Euclid's algo 
		b = a % b, a = prev_b;  //update a & b

		llt prev_y = y;

		// Update y and x 
		y = x - prev_q * prev_y;
		x = prev_y;
	}

	// Make x positive 
	while (x < 0) x += orig_b;

	cout << "Key is valid if 0: " << ((orig_a * x) - 1) % orig_b << endl;

	return x;
}

//llt calc_e(llt p, llt q, llt phiN)
//{
//	for (llt i = 2; i < phiN; i++)
//	{
//		if (phiN % i == 0)
//			continue;
//
//		if (is_prime(i) == 1 && i != p && i != q && i >= p / 2)
//		{
//			return i;
//		}
//	}
//	return -1;
//}

llt valid_e(llt phiN, llt e)
{
	if (phiN % e == 0)
	{
		//cout << "Please choose another e value for best encryption" << endl;
		return -1;
	}
	else
		return e;
}

void keygen(llt p, llt q, llt e, llt out[])
/*
Inputs: p, q, e, each an llt (= long long)
Outputs: out array with 5 elements 0 - p, 1 - q, 2 - e, 3 - N, 4 - private key pair d
Function: generate N and d RSA public and private keys for a given p, q, and e. Can be run multiple times 
	with the same p and q but changing e to generate new private keys.
Dependencies: simplified_eea_modInverse(), valid_e() 
Comments: will fail if e chosen is not a good value; feel free to comment out cout statements. Tested with p, q, e of up to 6 digits each
*/
{
	llt N; //= 0;
	llt d; //= 0;
	llt phiN = 0;

	cout << "Welcome to RSA KeyGen" << endl;

	//step 1: calculate N
	N = p * q;
	cout << "Step 1: N = p*q => " << N << " = " << p << "*" << q << endl;

	//step 2: determine phiN
	phiN = (p - 1) * (q - 1);
	cout << "Step 2: phi(N) = (p-1)*(q-1) => " << phiN << " = " << (p - 1) << "*" << (q - 1) << endl;

	//step 3: choose e, public key is set
	//e = calc_e(p, q, phiN);
	cout << "Step 3: Choose e = " << e << endl;
	e = valid_e(phiN, e);
	if (e == -1)
	{
		cout << "Please choose another e value for best encryption." << endl;
		return;
	}

	cout << "The Public Key is (" << N << ", " << e << ")" << endl;

	//step 4: solve for private key d using Extended Euclidean Algorithm
	d = simplified_eea_modInverse(e, phiN);

	cout << "Step 4: Private Key for e = " << e << " is d = " << d << endl;

	out[0] = p;  //p
	out[1] = q;  //q
	out[2] = e;  //e
	out[3] = N;  //N
	out[4] = d;  //d
}
int main()
{
	long long p = 104659;
	long long q = 100907;
	long long e = 65537;

	//llt p = in[0];//104659;//1049;//5;//104659;
//llt q = in[1];//100907;//1487;//11;//100907;
//llt e = in[2];//45389;//641;//17;//45389;
	llt out[5] = { 1, 2, 3, 4, 5 };
	//long long in[3] = { p,q,e };

	string varname = "p: ";

	//cout << "before calling keygen " << endl;

	//for (int i = 0; i < 5; i++) {
	//	cout << "out[" << i << "]: " << out[i] << endl;
	//}

	keygen(p, q, e, out);

	/*cout << "after calling keygen " << endl;*/

	for (int i = 0; i < 5; i++) {
		if (i == 0)
			varname = "p";
		else if (i == 1)
			varname = "q";
		else if (i == 2)
			varname = "e";
		else if (i == 3)
			varname = "N";
		else
			varname = "d";
		cout << varname.data() << ": " << out[i] << endl;
	}

	//cin.get();

	return (0);
}


// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
