/* CSCI 261 Lab 3B: Multiplication Tables
*
* Author: Nic McClellan
*
* This lab will output a multiplication table based on a users inputs.
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





int main() {
    int userMultiplier = 0;
    int userMultiplic = 0;
    int rowVariable = 2;

    // get first input 1-11
    do {
        cin >> userMultiplier;
    } while (userMultiplier <= 1 || userMultiplier >= 11);

    // get second input 1-11
    do {
        cin >> userMultiplic;
    } while (userMultiplic <= 1 || userMultiplic >= 11);

    //making the outside of table
    cout << ".....1";
    while(rowVariable <= userMultiplic){
        cout << setw(4) << setfill('.') << rowVariable;
        rowVariable += 1;

    }
    cout << endl;


    //making the inside of table
    for (int i = 0; i < userMultiplier; ++i) {
        cout << setw(2) << setfill('.') << i + 1;
        for (int j = 0; j < userMultiplic; ++j) {
            cout << setw(4) << setfill('.') << (i + 1) * (j + 1);
        }
        cout << endl;
    }


}










   /* cout << "......1";

    while(rowVariable <= userMultiplic){
        cout << setw(4) << setfill ('.') << (rowVariable);
        rowVariable += 1;
    }
    cout << endl;

    rowVariable = 2;
    while(columnVariable <= userMultiplier){
        cout << setw(2) << setfill('.') << columnVariable;
        cout << setw(4) << setfill('.') << columnVariable;
        while(rowVariable <= userMultiplic){
            cout << setw(4) << setfill('.') << (rowVariable * columnVariable);
        }
        cout << endl;
        columnVariable += 1;

    }*/


/*for(int j = 1; j <= userMultiplier; ++j){

}*/

