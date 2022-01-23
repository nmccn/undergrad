/*
* CSCI 261 Lab 7C: Translate the Moosage.
*
* Author: Nic McClellan & Chloe McCaffrey
*
*
* This program will read a text file containing a hidden message made by aliens, in order to save all the cows we must decyper the message.

*/

// For cin, cout, etc.
#include <iostream>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

// for line manipulations
#include <iomanip>

//for file reading/writing
#include <fstream>

using namespace std;

int main () {
    //variable for temp characters
    char c;

    //create input/output stream for the files
    ifstream hiddenMsg;
    ofstream notSoHiddenMsg;

    //open the input/output files
    notSoHiddenMsg.open("decipheredMessage.txt");
    hiddenMsg.open("secretMessage.txt");

    //check to see if the output file opened
    if (notSoHiddenMsg.fail()) {
        cerr << "Error opening output file." << endl;
        notSoHiddenMsg.close();
        exit(1);
    }

    //check to see if the input file opened
    if (hiddenMsg.fail()) {
        cerr << "Error opening input file." << endl;
        hiddenMsg.close();
        exit(2);
    }

    //loop reading all characters in c, then adjusts based on code, and outputs to the new file.
    while (hiddenMsg.get(c)) {
        if (c == '\n') {
            notSoHiddenMsg << c;
        } else if (c == '~') {
            notSoHiddenMsg << " ";
        } else {
            notSoHiddenMsg << char(c + 1);
        }
    }

    //close the 2 files
    hiddenMsg.close();
    notSoHiddenMsg.close();
}