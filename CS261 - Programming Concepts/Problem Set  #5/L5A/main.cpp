/* CSCI 261 Lab 5A: Input and Print an Array
*
* Author: Nic McClellan 
*
*
* Prompts the user for 15 values to store in an array, and then outputs the 15 values in order to the user.
*/

// For cin, cout, etc.
#include <iostream>

// This is for the use of math functions such as the square root and powers.
#include <cmath>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

//for random number generator
#include <cstdlib>

// for line manipulations
#include <iomanip>

int main(){
    //CONSTANT FOR THE NUMBER OF ENTRIES
    const int NUM_VALUES = 15;
    //INITIALIZE THE ARRAY WITH NUM_VALUES ENTRIES.
    int userArray[NUM_VALUES];

    //INTRO TO THE GAME
    cout << "Hey! Witness my first array mojo!" << endl;
    cout << "Enter 15 numbers and I will tell you what they are." << endl;

    //FOR LOOP GETTING USER INPUT
    for(int i = 0; i <= NUM_VALUES - 1; i++){
        //GETTING INPUT
        int userInput;
        cout << "Number " << i+1 << ": ";
        cin >> userInput;

        //ASSIGNING TO INDEX VALUE OF i
        userArray[i] = userInput;
    }

    //ANOTHER GAME UPDATE
    cout << "So awesome!" << endl;

    //FOR LOOP OUTPUTTING THE GIVEN ARRAY
    cout << "The numbers are: ";
    for(int j = 0; j <= NUM_VALUES - 1; j++){
        cout << userArray[j] << " ";
        //OUTRO
        if(j == NUM_VALUES - 1){
            cout << "\n";
            cout << "Have a nice day!";
        }
    }

}
