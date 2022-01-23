/* CSCI 261 Lab 5C: Matrix Transposition
*
* Author: Nic McClellan
*
*
* After prompting the user for a matrix of a globally defined size, the program finds the transpose and outputs it to the screen.
*/

// For cin, cout, etc.
#include <iostream>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

// for line manipulations
#include <iomanip>

//GLOBAL VARIABLES
//declare constants for the rows/columns so that they can be easily changed throughtout the program
const int NUM_ROWS = 4;
const int NUM_COLS = 3;

//creating two matrices that will be used to store the values, one for the original and another for the transpose
int userMatrix[NUM_ROWS][NUM_COLS];
int transMatrix[NUM_COLS][NUM_ROWS];

//FUNCTION TO GET THE USER MATRIX
int getUserMatrix(const int NUM_ROWS, const int NUM_COLS) {
    //For loop to get original matrix
    for (int i = 0; i < NUM_ROWS; i++) {
        for (int j = 0; j < NUM_COLS; j++) {
            cout << "Enter Row " << i + 1 << " Column " << j + 1 << ": ";
            cin >> userMatrix[i][j];
        }
    }
    cout << "\n";

    //For loop to output original matrix Note: May be better way to do the [] of the matrix.
    cout << "The matrix you entered is: " << endl;
    for (int i = 0; i < NUM_ROWS; i++) {
        cout << "[";
        for (int j = 0; j < NUM_COLS; j++) {
            cout << setw(6) << userMatrix[i][j];
            cout << " " ;
        }
        cout << "]";
        cout << "\n";
    }
    cout << "\n";
    return userMatrix[NUM_ROWS][NUM_COLS];
}

//FUNCTION TO FIND THE TRANSPOSE AND OUTPUT TO SCREEN (col/rows flipped)
void getTransMatrix(int userMatrix[NUM_ROWS][NUM_COLS]) {
    //For loop to generate transpose
    for (int i = 0; i < NUM_COLS; i++) {
        for (int j = 0; j < NUM_ROWS; j++) {
            transMatrix[i][j] = userMatrix[j][i];
        }
    }

    //For loop to output transpose
    cout << "The transpose of the matrix is: " << endl;
    for (int i = 0; i < NUM_COLS; i++) {
        cout << "[";
        for (int j = 0; j < NUM_ROWS; j++) {
            cout << setw(6) << transMatrix[i][j];
            cout << " " ;
        }
        cout << "]";
        cout << "\n";
    }
    cout << "\n";
    cout << "Have a nice day!";
}

//Actual calculations using the two functions and global variables above. can be easily changed
int main(){

    getUserMatrix(NUM_ROWS, NUM_COLS);
    getTransMatrix(userMatrix);

}