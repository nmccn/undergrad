/* CSCI 261 Lab 3A: RPS Multiple games
*
* Author: Nic McClellan
*
* This portion for the lab includes determining the winner of the game of RPS based on the player input and random
* selection made by the computer.
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
int main() {

    char playerChoice = ' ';
    srand(time(0));                                         //seeding for the random function with respect to time
    int computerChoice;                                     //rand() % n-1. This is working as intended, returning 0,1,2
    bool isGameRunning = true;
    char playAgain = ' ';
    int playerWins= 0;
    int playerLosses= 0;
    int playerTies= 0;

//Added while loop to continue running through the program as long as our boolean isGameRunning is true.
    while (isGameRunning == true) {
        //This is the portion for the player choice/output and introduction to the game.
        cout << "Welcome to rock paper scissors, make your choice: (R,P,S)" << endl;
        cout << "Player Choice: ";
        cin >> playerChoice;
        cout << "\n\n";
        int computerChoice = rand() % 3;

        //Player inputs converted to choice in RPS
        if (playerChoice == 'R' || playerChoice == 'r') {        //Rock option
            cout << "Player chose Rock" << endl;
            playerChoice = 'R';
        } else if (playerChoice == 'S' || playerChoice == 's') {   //Scissor option
            cout << "Player chose Scissor" << endl;
            playerChoice = 'S';
        } else if (playerChoice == 'P' || playerChoice == 'p') {   //Paper option
            cout << "Player chose Paper" << endl;
            playerChoice = 'P';
        } else {
            cout << "That is not a valid choice." << endl;       //All other inputs
        }

        //This is the portion for the computer choice/output
        if (computerChoice == 0) {
            cout << "Computer chose Rock." << endl;              //0 corresponds to Rock
            computerChoice = 'R';
        } else if (computerChoice == 1) {
            cout << "Computer chose Paper." << endl;             //1 corresponds to Paper
            computerChoice = 'P';
        } else if (computerChoice == 2) {
            cout << "Computer chose Scissor." << endl;           //2 corresponds to Scissor
            computerChoice = 'S';
        } else {
            cout << "The program broke :-("
                 << endl;                                        //In theory shouldn't ever be executed, but covers bases
        }

        cout << "\n\n";

        //This section will determine the winner of the game and keep track of W/L/D
        if (playerChoice == 'R' && computerChoice == 'P') {
            cout << "Paper beats rock. Computer Wins!" << endl;
            playerLosses += 1;
        } else if (playerChoice == 'P' && computerChoice == 'R') {
            cout << "Paper beats rock. Player Wins!" << endl;
            playerWins += 1;
        } else if (playerChoice == 'R' && computerChoice == 'S') {
            cout << "Rock beats scissors. Player Wins!" << endl;
            playerWins +=1;
        } else if (playerChoice == 'S' && computerChoice == 'R') {
            cout << "Rock beats scissors. Computer Wins!" << endl;
            playerLosses += 1;
        } else if (playerChoice == 'P' && computerChoice == 'S') {
            cout << "Scissor beats paper. Computer Wins!" << endl;
            playerLosses += 1;
        } else if (playerChoice == 'S' && computerChoice == 'P') {
            cout << "Scissor beats paper. Player Wins!" << endl;
            playerWins += 1;
        } else if (playerChoice == computerChoice) {
            cout << "The game is a draw!" << endl;
            playerTies += 1;
        } else {
            cout << "You must enter a valid option, try again!" << endl;
        }
        cout << "Do you want to play again? (Y/N)" << endl;
        cin >> playAgain;
        if(playAgain == 'Y' || playAgain == 'y'){
            isGameRunning = true;
        }
        else if(playAgain == 'N' || playAgain == 'n') {
            isGameRunning = false;
            cout << "Thanks for playing!" << endl;
            cout << "You have " << playerWins << " game(s) won, " << playerLosses << " game(s) lost, " << "and " << playerTies << " game(s) tied.";
        }
        else{
            cout << "That is not a valid input, ending game" << endl;
        }

    }



}


