#include "rsa.h"
#include <iostream>
using std::cout;
using std::endl;

vlint_t encrypt(const vlint_t base, const vlint_t exponent, const vlint_t modulus)
{
	vlint_t result = 1;

	for (int i = 0; i < exponent; i++)			// Doing this avoids working with gigantic numbers
		result = (result*base) % modulus;		// This is the meat of the algorithm

	return result;
}

vlint_t decrypt(vlint_t base, vlint_t dKey, vlint_t modulus)
{
	// TODO
	// Same as encrypt with different formula

	vlint_t result = 1;

	for (int i = 0; i < dKey; i++)			// Doing this avoids working with gigantic numbers
		result = (result*base) % modulus;		// This is the meat of the algorithm

	return result;
}

vlint_t simplified_eea_modInverse(vlint_t a, vlint_t b)
{
	//EEA finds gcd of a & b and x, y such that ax + by = gcd(a, b)
	//this function finds x and y such that ax + by = 1 because a and b are expected to be coprime i.e. gcd(a, b) = 1
	//we are interested only in x since it's the modulo inverse of a i.e. the RSA private key d for the given public key e = a and totient = b 

	vlint_t orig_a = a;
	vlint_t orig_b = b; //original b. needed to convert -ve x to +ve if x is caclulated as -ve

						//cout << "A: " << orig_a << ", B: " << origi_b << endl;

	vlint_t y = 0, x = 1;

	if (b == 1)
		return 0;

	while (a > 1)   //loop until a was set as 1 in the previous loop i.e for gcd condition gcd(a,b) = 1
	{
		// prev_q is the quotient of previous a and b. a & b are updated later in this loop
		vlint_t prev_q = a / b;
		vlint_t prev_b = b;

		// b is remainder now, process same as 
		// Euclid's algo 
		b = a % b, a = prev_b;  //update a & b

		vlint_t prev_y = y;

		// Update y and x 
		y = x - prev_q * prev_y;
		x = prev_y;
	}

	// Make x positive 
	while (x < 0) x += orig_b;

	//cout << "Key is valid if 0: " << ((orig_a * x) - 1) % orig_b << endl;

	return x;
}

vlint_t valid_e(vlint_t phiN, vlint_t e)
{
	if (phiN % e == 0)
	{
		//cout << "Please choose another e value for best encryption" << endl;
		return -1;
	}
	else
		return e;
}

void keygen(vlint_t p, vlint_t q, vlint_t e, vlint_t out[])
/*
Inputs: p, q, e, each an vlint_t (= long long)
Outputs: out array with 5 elements 0 - p, 1 - q, 2 - e, 3 - N, 4 - private key pair d
Function: generate N and d RSA public and private keys for a given p, q, and e. Can be run multiple times
with the same p and q but changing e to generate new private keys.
Dependencies: simplified_eea_modInverse(), valid_e()
Comments: will fail if e chosen is not a good value; feel free to comment out cout statements. Tested with p, q, e of up to 6 digits each
*/
{
	vlint_t N; //= 0;
	vlint_t d; //= 0;
	vlint_t phiN = 0;

	//cout << "Welcome to RSA KeyGen" << endl;

	//step 1: calculate N
	N = p * q;
	//cout << "Step 1: N = p*q => " << N << " = " << p << "*" << q << endl;

	//step 2: determine phiN
	phiN = (p - 1) * (q - 1);
	//cout << "Step 2: phi(N) = (p-1)*(q-1) => " << phiN << " = " << (p - 1) << "*" << (q - 1) << endl;

	//step 3: choose e, public key is set
	//e = calc_e(p, q, phiN);
	//cout << "Step 3: Choose e = " << e << endl;
	e = valid_e(phiN, e);
	if (e == -1)
	{
		cout << "Please choose another e value for best encryption." << endl;
		exit(1);
	}

	//cout << "The Public Key is (" << N << ", " << e << ")" << endl;

	//step 4: solve for private key d using Extended Euclidean Algorithm
	d = simplified_eea_modInverse(e, phiN);

	//cout << "Step 4: Private Key for e = " << e << " is d = " << d << endl;

	out[0] = p;  //p
	out[1] = q;  //q
	out[2] = e;  //e
	out[3] = N;  //N
	out[4] = d;  //d
}