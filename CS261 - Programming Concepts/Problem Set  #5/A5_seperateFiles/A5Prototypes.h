/* CSCI 261 Assignment A5: Hangman
 * FUNCTION PROTOTYPES
*
* Author: Nic McClellan
*
*
* This program will be a functional game of hangman with a predefined word and a limited amount (7) of incorrect guesses (a la hangman).
 *
 * THIS FILE WILL SPECIFICALLY HOLD ALL OF THE FUNCTION DEFINITIONS.
*/

#ifndef A5_A5PROTOTYPES_H
#define A5_A5PROTOTYPES_H
#endif //A5_A5PROTOTYPES_H


// For cin, cout, etc.
#include <iostream>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

// for line manipulations
#include <iomanip>

//DECLARING GLOBAL VARIABLES
//constants for word size and size of the guessed letter. Important to note that the array could overflow if people were to intentionally break the program.
const int WORD_SIZE = 6;
const int LETTERS_IN_ALPH = 26;

//FUNCTION TO PRINT CURRENT GAME BOARD
void printGameBoard();

//FUNCTION TO ADD GUESS TO THE ARRAY OF GUESSED CHARACTERS
void appendAlreadyGuessed(char playerGuess);

//FUNCTION TO TEST IF THE LETTER HAS BEEN GUESSED
bool isLetterGuessed(char playerGuess);

//FUNCTION TO TEST IF THE LETTER IS IN THE SECRET WORD
bool isInSecretWord(char playerGuess);

//FUNCTION TO CHECK IF PUZZLE IS SOLVED
bool isPuzzleSolved(char currentBoard[]);

//FUNCTION TO PLAY THE GAME
void playGame();

