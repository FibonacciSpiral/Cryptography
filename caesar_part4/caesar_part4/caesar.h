/*
 * caesar.h
 * 
 * This file will hold the declarations for functions relating to
 * caesar deciphering
 */

#ifndef CAESAR_H
#define CAESAR_H

#define ASCII_UPPER_A 65
#define ASCII_UPPER_Z 90
#define ASCII_LOWER_A 97
#define ASCII_LOWER_Z 122
#define MAX_CHARS 2000

#include <fstream>
#include <iostream>
#include <string>

// split() will split the file opened with input_file into 26 output files
void split(std::ifstream& input_file);

// caesar_decipher() will decipher the input stream to the output stream given a key
// function also simultaneously scores each translation
void caesar_decipher(const int key, std::ifstream& file_in, std::ofstream& file_out);

// decrypt_char() decrypts a single character given the character and integer key as parameters
char decrypt_char(char ciphertext, const int key);

// score() returns a score for an individual alphabetic character
int score(char input_char);

// crack() runs each necessary function in attempt to break the cipher code
void crack(std::ifstream& input_file);

bool is_alpha(char c);
bool is_upper(char c);

#endif
