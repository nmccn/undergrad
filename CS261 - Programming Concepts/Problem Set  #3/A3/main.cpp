/* CSCI 261: Assignment 3: Guess my number
 *
 * Author:  Nicholas McClellan
 * This is a guess my number game with user defined number ranges. 
 */

// For cin, cout, etc.
#include <iostream>

// This is for the use of math functions such as the square root and powers.
#include <cmath>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

//for random number generator
#include <cstdlib>

// The main function is the starting point of any C++ program
int main(){

    int playerGuess;
    int playerAttempts = 0;
    int computerNumber;
    int lowerBound = 0;
    int upperBound = 0;
    const int TOO_HIGH_DIFFERENCE = 25;
    const int TOO_CLOSE_DIFFERENCE = 5;
    srand(time(0));

    // introduction
    cout << "Hold onto your pants, we're about to play guess-the-numbah!" << endl;


    //gets lowerbound
    do
    {
        cout << "Enter the lowest possible value: ";
        cin >> lowerBound;

    } while (lowerBound <= 0);

    //gets upperbound
    do
    {
        cout << "Enter the highest possible value: ";
        cin >> upperBound;
    } while(upperBound <= lowerBound + 99);

    //generates random number

    srand(time(0));
    int computerRange = upperBound - lowerBound;
    int computerChoice = rand() % computerRange + lowerBound;


    //plays the game
    do
    {
        cout << "Pick a number between " << lowerBound << " and " << upperBound << ": ";
        cin >> playerGuess;
        if(playerGuess >= lowerBound  && playerGuess <= upperBound) {
            if (playerGuess < computerChoice) {
                if (computerChoice - playerGuess <= TOO_CLOSE_DIFFERENCE) {
                    cout << "Too low! Oooh you're close!" << endl;
                    playerAttempts += 1;
                } else if (computerChoice - playerGuess >= TOO_HIGH_DIFFERENCE) {
                    cout << "Too low! Not even close!" << endl;
                    playerAttempts += 1;
                } else {
                    cout << "Tow low!" << endl;
                    playerAttempts += 1;
                }
            } else if (playerGuess > computerChoice) {
                if (playerGuess - computerChoice >= TOO_HIGH_DIFFERENCE) {
                    cout << "Too high! Not even close!" << endl;
                    playerAttempts += 1;
                } else if (playerGuess - computerChoice <= TOO_CLOSE_DIFFERENCE) {
                    cout << "Too high! Oooh you're close!" << endl;
                    playerAttempts += 1;
                } else {
                    cout << "Too high!" << endl;
                    playerAttempts += 1;
                }
            } else {
                cout << "That's right you won the game in " << playerAttempts + 1 << " tries." << endl;
            }
        }
        else{
            cout << "Invalid guess." << endl;
        }
    }while (playerGuess != computerChoice);

}

