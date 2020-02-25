#ifndef RSA_H
#define RSA_H

typedef long long int vlint_t;

vlint_t encrypt(const vlint_t base, const vlint_t exponent, const vlint_t modulus);
vlint_t decrypt(const vlint_t base, const vlint_t dKey, const vlint_t modulus);
vlint_t simplified_eea_modInverse(vlint_t a, vlint_t b);
vlint_t valid_e(vlint_t phiN, vlint_t e);
void keygen(vlint_t p, vlint_t q, vlint_t e, vlint_t out[]);

#endif
