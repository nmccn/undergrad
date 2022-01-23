/*
* CSCI 261 Lab 7B: Starcraft.
*
* Author: Nic McClellan & Chloe McCaffrey
*
*
* This program will read a text file containing information about stars, and then will output the useful information, such as
* location and brightness, to make drawing the stars easier.
*/

// For cin, cout, etc.
#include <iostream>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

// for line manipulations
#include <iomanip>

//for string operations
#include <string>

//for vector operations
#include <vector>

//for file reading/writing
#include <fstream>

//string stream
#include <sstream>



int main() {
    //variables for the dimension of the SFML window
    const int HEIGHT = 640;
    const int WIDTH = 640;

    //vectors for the 3 columns of data being output to terminal (x pos, y pos, and brightness)
    vector<double> xPosition;
    vector<double> yPosition;
    vector<double> sBrightness;

    //variable for the tempVect holding each line separate.
    vector<string> tempVect;

    //loop to read the data
    ifstream dataSheet;
    dataSheet.open("stars.txt");

    //check to see if the file opened
    if (dataSheet.fail()) {
        cerr << "Error opening a file" << endl;
        dataSheet.close();
        exit(1);
    }

    //while not at the end of file, get the line and push back to a vector separating each line.
    while (!dataSheet.eof()) {
        string tempStr;
        getline(dataSheet, tempStr);
        tempVect.push_back(tempStr);
    }

    //separates the sentences by "word", and stores in another vector. Using the copy function from sstream library. A fancy copy/swap
    vector<string> split;
    for(int i = 0; i < tempVect.size(); i++) {
        istringstream iss(tempVect.at(i));
        copy(istream_iterator<string>(iss),
             istream_iterator<string>(),
             back_inserter(split));
    }

    //populates the original xPosition vector, creates a double from string; stod
    for(int i = 0; i < split.size(); i+=6){
        double tempX = stod(split.at(i));
        xPosition.push_back(tempX);
    }

    //updates the value to the correct coord system
    for(int i = 0; i < xPosition.size(); i++){
        xPosition.at(i) = (int)((xPosition.at(i) + 1) * WIDTH / 2);
    }

    //populates the original yPosition Vector, creates a double from string again.
    for(int i = 1; i < split.size(); i+=6){
        double tempY = stod(split.at(i));
        yPosition.push_back(tempY);
    }

    //update value to correct coord system
    for(int i = 0; i < yPosition.size(); i++){
        yPosition.at(i) = (int)((-yPosition.at(i) + 1) * HEIGHT / 2);
    }

    //populate the brightness vector using same method as above.
    for(int i = 3; i < split.size(); i+=6){
        double tempB = stod(split.at(i));
        sBrightness.push_back(tempB);
    }

    //figure out which stars are valid based on brightness.
    for(int i = 0; i < sBrightness.size(); i++){
        if(sBrightness.at(i) >= 0 && sBrightness.at(i) <= 8.0){
            cout << xPosition.at(i) << "\t" << yPosition.at(i) << "\t" << sBrightness.at(i);
            cout << endl;
        }
        else{
            break;
        }
    }

    //close the file when done
    dataSheet.close();
}
