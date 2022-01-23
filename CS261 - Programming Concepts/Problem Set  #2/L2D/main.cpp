/* CSCI 261 Lab 2D: RPS: State Your Choice
*
* Author: Nic McClellan
*
* Editing the RPS program to convert the random number assigned to the computer to a choice relevant to RPS, as well
* as allowing users to input lower case letters. 
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
    int computerChoice = rand() %3;                         //rand() % n-1. This is working as intended, returning 0,1,2
    srand(time(0));                                         //seeding for the random function with respect to time

    //This is the portion for the player choice/output and introduction to the game.

    cout << "Welcome to rock paper scissors, make your choice: (R,P,S)" << endl;
    cout << "Player Choice: " ;
    cin >> playerChoice;
    cout << "\n\n";
    if (playerChoice == 'R' || playerChoice == 'r'){        //Rock option
        cout << "Player chose Rock." << endl;
    }
    else if (playerChoice == 'S' || playerChoice == 's'){   //Scissor option
        cout << "Player chose Scissor." << endl;
    }
    else if (playerChoice == 'P' || playerChoice == 'p'){   //Paper option
        cout << "Player chose Paper." << endl;
    }
    else{
        cout << "That is not a valid choice." << endl;      //All other inputs
    }

    //This is the portion for the computer choice/output

    if (computerChoice == 0){
        cout << "Computer chose Rock." << endl;              //0 corresponds to Rock
    }
    else if (computerChoice == 1){
        cout << "Computer chose Paper." << endl;             //1 corresponds to Paper
    }
    else if (computerChoice == 2){
        cout << "Computer chose Scissor." << endl;           //2 corresponds to Scissor
    }
    else{
        cout << "The program broke :-(" << endl;             //Not exactly useful, but it would have told the user if t
                                                             // he computer selected a number it shouldn't have
    }
}


