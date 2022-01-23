/* CSCI 261 Lab 4A: Yahtzee Function
*
* Author: Nic McClellan & Chloe McCaffrey
*
* This lab will determine if the die rolled are eligible for a large straight & how many points rolling sixes will net you
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

bool isLargeStraight(int die1, int die2, int die3, int die4, int die5) {
    // variable to update to check if large straight
    bool straightCheck = false;

    // first check for the case of rolling 2-6
    if (die1 == 6 || die2 == 6 || die3 == 6 || die4 == 6 || die5 == 6) {
        if (die1 == 5 || die2 == 5 || die3 == 5 || die4 == 5 || die5 == 5) {
            if (die1 == 4 || die2 == 4 || die3 == 4 || die4 == 4 || die5 == 4) {
                if (die1 == 3 || die2 == 3 || die3 == 3 || die4 == 3 || die5 == 3) {
                    if (die1 == 2 || die2 == 2 || die3 == 2 || die4 == 2 || die5 == 2) {
                        straightCheck = true;
                    }
                }
            }
        }
    }
    // now check for the case of rolling 1-5
    else if (die1 == 5 || die2 == 5 || die3 == 5 || die4 == 5 || die5 == 5) {
        if (die1 == 4 || die2 == 4 || die3 == 4 || die4 == 4 || die5 == 4) {
            if (die1 == 3 || die2 == 3 || die3 == 3 || die4 == 3 || die5 == 3) {
                if (die1 == 2 || die2 == 2 || die3 == 2 || die4 == 2 || die5 == 2) {
                    if (die1 == 1 || die2 == 1 || die3 == 1 || die4 == 1 || die5 == 1) {
                        straightCheck = true;
                    }
                }
            }
        }
    }
    //all other cases
    else {
        straightCheck = false;
    }
    //cout << straightCheck << endl;
    return straightCheck;
}


bool isSixes(int die1, int die2, int die3, int die4, int die5){
    bool sixCheck = false;

    if(die1 == 6) {
        sixCheck = true;
    }
    else if (die2 == 6) {
        sixCheck = true;
    }
    else if (die3 == 6) {
        sixCheck = true;
    }
    else if (die4 == 6) {
        sixCheck = true;
    }
    else if (die5 == 6) {
        sixCheck = true;
    }
    else{
        sixCheck = false;
    }

    //cout << sixesPoints << endl;
    return sixCheck;
}




//testing

int main(){
    isLargeStraight(6, 3, 4, 5, 2);
    isSixes(6,1,1,1,6);
    isSixes(6,1,1,1,1);
    isSixes(6,6,6,6,6);
    isSixes(1,1,1,1,1);
}