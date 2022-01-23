//
// Created by Nicholas McClellan on 2019-04-07.
//

#ifndef SET6_A6_PROTOTYPE_H
#define SET6_A6_PROTOTYPE_H

// For cin, cout, etc.
#include <iostream>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

// for line manipulations
#include <iomanip>

//for string operations
#include <string>

//for vector operations
#include <vector>

#include "struct.h"

using namespace std;

//function to get input from user, including prompt and stopping condition.
string getUserSentence();

//function to make all adjustments to othe string, such as remove punctuation and make everything uppercase
string inputAdjustments(string& userText);

//function to find unique words, and tracks how often they appear. Information is then stored in countKeeper
void findWordFrequency(string userText, vector<WordCount>& countKeeper);

//function that ultimately updates the countkeeper vectors by calling findWordFrequency to update counts etc.
void determineWord(string userText, vector<WordCount>& countKeeper);

//function to sort the words. follows a selection sort boilerplate.
void sortWords(vector<WordCount>& countKeeper, int vectorSize);

//function to simply output the words and their counts
void outputWords(vector<WordCount> countKeeper);

//function to get the most frequent word
void mostFrequentWord(vector<WordCount> countKeeper);

//similar function to get the least frequent word
void leastFrequentWord(vector<WordCount> countKeeper);

//function to create and store all letters in user input in an array, very similar to the countKeeper vector.
int findLetterFrequency(string userText, WordCount userLetters[]);

//function to get the most frequent letter
void mostFrequentLetter(WordCount userLetters[]);

//similar function to get the least frequent word
void leastFrequentLetter(WordCount userLetters[]);

#endif //SET6_A6_PROTOTYPE_H
