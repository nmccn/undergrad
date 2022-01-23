//
// Created by Nicholas McClellan on 2019-02-20.
//

/// ****MANY DO/WHILE LOOPS TO PREVENT BAD USER INPUTS*****

//Different libraries for things like mathematical operations/random numbers/cout/cin/endl/std::
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <cmath>
#include "A4Prototypes.h"
using namespace std;

//poundsToKilograms() gets the input from user as well as calls the calculation with the input as an argument.
void poundsToKilograms(){
    double inPounds = -1;
    //Loop Preventing bad user inputs
    do {
        cout << "Enter value to convert to kg: ";
        cin >> inPounds;
    }while(inPounds < 0);
    doPoundsToKilograms(inPounds);
}

//doPoundsToKilograms() does the calculation to convert from lbs -> kg and then returns/displays the result.
double doPoundsToKilograms(double inPounds){
    double convertKG = 0;
    //converting input
    convertKG = (inPounds / 2.205);
    //returning/displaying output
    cout << "Answer: " << convertKG << endl;
    cout << "\n\n";
    return convertKG;
}

//feetToMeters() gets the input from user as well as calls the calculation with the input as an argument.
void feetToMeters(){
    double inFeet = -1;
    //Loop to prevent bad user inputs
    do {
        cout << "Enter value to convert to m: ";
        cin >> inFeet;
    }while(inFeet < 0);
    doFeetToMeters(inFeet);
}

//doFeetToMeters does the calculation to convert from ft -> m and then returns/displays the result.
double doFeetToMeters(double inFeet){
    double convertMeters = 0;
    //converting input
    convertMeters = (inFeet / 3.281);
    //returning/displaying output
    cout << "Answer: " << convertMeters << endl;
    cout << "\n\n";
    return convertMeters;
}

//bodyMassIndex() gets the inputs from user as well as calls the calculation with the input as an argument.
void bodyMassIndex(){
    double inKilograms = -1;
    double inMeters = -1;
    //Loop to prevent bad user inputs
    do {
        cout << "Enter values to calculate BMI (kg m): ";
        cin >> inKilograms >> inMeters;
    }while(inKilograms < 0 || inMeters < 0);
    doBMI(inKilograms, inMeters);
}

//doBMI does the calculation to convert from kg/m^2 -> BMI and then returns/displays the result.
double doBMI(double inKilograms, double inMeters){
    double calcBMI = 0;
    //converting input
    calcBMI = (inKilograms / (inMeters * inMeters));
    //returning/displaying output
    cout << "Answer: " << calcBMI << endl;
    cout << "\n\n";
    return calcBMI;
}

//TWO EXTRA FUNCTIONS PER THE REQUIREMENT ON ASSIGNMENT
//

//poundsToKilograms() gets the input from user as well as calls the calculation with the input as an argument.
void inchesToCentimeters(){
    double inInches = -1;
    //Loop Preventing bad user inputs
    do {
        cout << "Enter value to convert to cm: ";
        cin >> inInches;
    }while(inInches < 0);
    doInchesToCM(inInches);
}

//doPoundsToKilograms() does the calculation to convert from lbs -> kg and then returns/displays the result.
double doInchesToCM(double inInches){
    double convertCM = 0;
    //converting input
    convertCM = (inInches * 2.54);
    //returning/displaying output
    cout << "Answer: " << convertCM << endl;
    cout << "\n\n";
    return convertCM;
}

//
//
//Menu() does the bulk of the work, as it displays a home screen providing all possible inputs, and then calls functions
// to do the calculations requested by the user. Many things contained in loops for repeatability and to prevent breaking
//
//
void menu() {
    //Variables, one to prevent the user from inputting a bad choice, and another to store the choice.
    bool isValidInput = false;
    char userChoice = ' ';
    bool isStillRunning = true;
    //first loop keeps game playing until input Q/q on options menu.
    do {
        //second loop plays the game
        //requesting input for calculation choice
        do {
            //introducing the calculations
            cout << " (1) Pounds to Kilograms  " << endl;
            cout << " (2) Feet   to Meters     " << endl;
            cout << " (3) Body Mass Index (BMI)" << endl;
            cout << " (4) Inches to Centimeters" << endl;
            cout << " (Q) To close the program " << endl;
            cout << "\n";
            //label:
            cout << " Pick a calculation: ";
            cin >> userChoice;
            cout << "\n";
            if (userChoice == '1' || userChoice == '2' || userChoice == '3' || userChoice == '4' || userChoice == 'Q') {
                isValidInput = true;
            }
        } while (!isValidInput);

        //Switch Statement for deciding which functions to call
        switch (userChoice) {
            case '1':
                poundsToKilograms();
                break;
            case '2':
                feetToMeters();
                break;
            case '3':
                bodyMassIndex();
                break;
            case '4':
                inchesToCentimeters();
                break;
            case 'Q':
            case 'q':
                cout << "Thanks for using the program!";
                isStillRunning = false;
                break;
            default:
                break;
                //goto label; //This fix worked, but is not good for flow control. Without this the loop will repeat the menu options
                // not the worst thing, but could probably be fixed.
        }
    } while (isStillRunning);
}







