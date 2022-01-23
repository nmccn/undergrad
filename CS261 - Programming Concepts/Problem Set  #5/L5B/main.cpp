/* CSCI 261 Lab 5B: Find the Array Max
*
* Author: Nic McClellan
*
*
* After prompting the user for an array, and then displaying that array, the program finds the max and min values given.
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


//Function to find min and max of the array. The array itself is passed un-sized, and then the size is passed as a const int.
// The function compares the value at the index value with the current values of min/max
void arrayMinMax(int userInput[], const int USER_SIZE){
    //initialize min and max
    int arrayMax, arrayMin;
    for(int i = 0; i <= USER_SIZE - 1; i++) {
        //gives min and max the value of the first entry, so the program has a baseline to compare
        if(i == 0){
            arrayMax = userInput[i];
            arrayMin = userInput[i];
        }
        else if (userInput[i] > arrayMax) {
            arrayMax = userInput[i];
        }
        else if(userInput[i] < arrayMin) {
            arrayMin = userInput[i];
        }
        else {
            continue;
        }
    }
    cout << "The largest number is: " << arrayMax << endl;
    cout << "The smallest number is: " << arrayMin << endl;
    cout << "Gaze at my awesome." << endl;
    }


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
            cout << "Have a nice day!" << endl;
        }
    }

    //Finding Min and Max
    arrayMinMax(userArray, NUM_VALUES);

}
