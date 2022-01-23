/* CSCI 261 Lab 2C: RPS: Human vs. Computer
*
* Author: Nic McClellan
*
* Programming the basis of the RPS game, setting up the player choice selection, as well as the random number for the
* computer choice that will be useful in future labs.
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
    char computerChoice = ' ';
    srand(time(0));                                             //seed for the random number generator, with respect to time.


    cout << "Welcome to rock, paper, scissors. Make your choice: (R,P,S)" << endl;
    cout << "Player Choice: " ;
    cin >> playerChoice;
    cout << "\n\n";
        if (playerChoice == 'R' or playerChoice == 'r'){        //Rock option
            cout << "Player choice: " << playerChoice << endl;
        }
        else if (playerChoice == 'S' or playerChoice == 's'){   //Scissor option
            cout << "Player choice: " << playerChoice << endl;
        }
        else if (playerChoice == 'P' or playerChoice == 'p'){   //Paper option
            cout << "Player choice: " << playerChoice << endl;
        }
        else{
            cout << "That is not a valid choice." << endl;      //All other inputs
        }

cout << "Computer choice: " << rand() % 3 << endl;              //rand() % n-1. This is working as intended,
                                                                //returns values 0,1,2.
                                                                


}


