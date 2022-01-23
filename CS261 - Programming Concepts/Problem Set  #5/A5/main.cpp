/* CSCI 261 Assignment A5: Hangman
*
* Author: Nic McClellan
*
*
* This program will be a functional game of hangman with a predefined word and a limited amount (7) of incorrect guesses (a la hangman).
*/

// For cin, cout, etc.
#include <iostream>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

// for line manipulations
#include <iomanip>

//for the function definitions
//DECLARING GLOBAL VARIABLES
//constants for word size and size of the guessed letter. Important to note that the array could overflow if people were to intentionally break the program.
const int WORD_SIZE = 6;
const int LETTERS_IN_ALPH = 26;

//Different arrays for the different components of the game
char secretWord[WORD_SIZE] = {'C', 'A', 'C', 'T', 'U', 'S'};
char currentBoard[WORD_SIZE] = {'_','_','_','_','_','_',};
char alreadyGuessed[LETTERS_IN_ALPH];

//Game Conditions
bool isGuessed;
bool isInWord;
bool isSolved;
char playerGuess;
int playerAttempt = 0;
int guessLeft = 7;

//FUNCTION TO PRINT CURRENT GAME BOARD
void printGameBoard(){
    for(int i = 0; i < WORD_SIZE; i++){
        cout << currentBoard[i] << " " ;
    }
}

//FUNCTION TO ADD GUESS TO THE ARRAY OF GUESSED CHARACTERS
void appendAlreadyGuessed(char playerGuess){
    for(int i = 0; i < playerAttempt; i++){
        alreadyGuessed[i] = playerGuess;
    }
}

//FUNCTION TO TEST IF THE LETTER HAS BEEN GUESSED
bool isLetterGuessed(char playerGuess){
    for(int i = 0; i < LETTERS_IN_ALPH; i++){
        if(alreadyGuessed[i] == playerGuess) {
            isGuessed = true;
            break;
        }
        else{
            isGuessed = false;
        }
    }
    return isGuessed;
}

//FUNCTION TO TEST IF THE LETTER IS IN THE SECRET WORD
bool isInSecretWord(char playerGuess) {
    if (playerGuess == secretWord[0] || playerGuess == secretWord[1] || playerGuess == secretWord[2]
        || playerGuess == secretWord[3] || playerGuess == secretWord[4] || playerGuess == secretWord[5]) {
        isInWord = true;
    } else {
        isInWord = false;
    }
    for (int i = 0; i < WORD_SIZE; i++) {
        if (playerGuess == secretWord[i]) {
            currentBoard[i] = playerGuess;
        }
    }
    return isInWord;
}

//FUNCTION TO CHECK IF PUZZLE IS SOLVED
bool isPuzzleSolved(char currentBoard[]){
    //Huge if-statement that checks all values, with a for loop I could only get it to check for the last value. Could maybe use for loop + break;
    if(currentBoard[0] == secretWord[0] && currentBoard[1] == secretWord[1] && currentBoard[2] == secretWord[2]
    && currentBoard[3] == secretWord[3] && currentBoard[4] == secretWord[4] && currentBoard[5] == secretWord[5]){
        isSolved = true;
    }
    else{
        isSolved = false;
    }
    return isSolved;
}

//FUNCTION TO PLAY THE GAME
void playGame() {
    //initialize the guessed letter array
    for (int i = 0; i < 26; ++i){
        alreadyGuessed[i] = 1;
    }

    //introduction
    cout << "Welcome to Hangman!!" << endl;
    cout << "\n\n";

    //do while loop for playing the game
    do {
        cout << "Take a guess: ";
        printGameBoard();

        //user guess and conversion to uppercase to eliminate always checking both cases.
        cout << "\n";
        cout << "Your guess: ";
        cin >> playerGuess;
        playerAttempt += 1;
        playerGuess = toupper(playerGuess);

        //Checks if the letter is a valid guess (has been guessed before)
        isLetterGuessed(playerGuess);

        //conditional for if its not guessed, to add it to the guessed list.
        if (isLetterGuessed(playerGuess) == true){
            cout << "You already guessed " << playerGuess << ". Pick again." << endl;
            cout << "\n";
        }

        //Checks if the letter is in the secret word
        isInSecretWord(playerGuess);

        //conditions for if the guess is or is not in the word
        if (isInSecretWord(playerGuess) == false && isLetterGuessed(playerGuess) == false) {
            guessLeft -= 1;
            if (guessLeft == 0) {
                cout << "You lose. Try again!" << endl;
            }
            else {
                cout << "Sorry, no " << playerGuess << "'s . You have " << guessLeft << " wrong guesses remaining."
                     << endl;
                cout << "\n";
            }
        }
        else if (isInSecretWord(playerGuess) == true && isLetterGuessed(playerGuess) == false) {
            cout << "There's a(n) " << playerGuess << "!" << endl;
            cout << "\n";
        }

        //adds the guess to the list of guesses, after the program determines all of the other bool values.
        appendAlreadyGuessed(playerGuess);

    //stopping conditions, out of guesses or the puzzle is solved.
    } while (guessLeft > 0 && isPuzzleSolved(currentBoard) != true);

    //displays the winning board if the player wins, and exits the program otherwise.
    if(isPuzzleSolved(currentBoard) == true){
        cout << "CONGRATS! You solved the puzzle: ";
        printGameBoard();
    }
}




int main(){

   playGame();

}
