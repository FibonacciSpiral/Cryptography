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

#endif
