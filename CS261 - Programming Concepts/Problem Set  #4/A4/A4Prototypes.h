//
// Created by Nicholas McClellan on 2019-02-20.
//

#ifndef A4_A4PROTOTYPES_H
#define A4_A4PROTOTYPES_H
#endif //A4_A4PROTOTYPES_H

//Different libraries for things like mathematical operations/random numbers/cout/cin/endl/std::
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <cmath>
using namespace std;

//menu(), which has no parameters and no return value. This function displays the list of available calculations to the user,
// and then accepts a choice from the user. For practice, use a switch statement to decide which function gets called.
// Be sure to add a Quit option so the user can end the program gracefully.
void menu();

//poundsToKilograms(), which has no parameters and no return value. This function asks the user to input the number of pounds to convert,
// calls doPoundsToKilograms() to do the calculation, and then outputs the result returned.
void poundsToKilograms();

//doPoundsToKilograms(), which has one double parameter (pounds) and returns a double (kilograms).
// This function does the pounds to kilogram conversion, and then returns the results. Note: 1 pound is about 0.454 kilograms.
double doPoundsToKilograms(double inPounds);

//feetToMeters(), which has no parameters and no return value.
// This function asks the user to input the number of feet to convert, calls doFeetToMeters() to do the calculation, and then outputs the result returned.
void feetToMeters();

//doFeetToMeters(), which has one double parameter (feet) and returns a double (meters).
// This function does the feet to meter conversion, and then returns the results. Note: 1 foot is about 0.3048 meters.
double doFeetToMeters(double inFeet);

//bodyMassIndex(), which has no parameters and no return value.
// This function asks the user to input height (in feet) and weight (in pounds).
// Then, this function calls doPoundsToKilograms() and doFeetToMeters() to do conversions, and then calls doBMI() to do the calculation.
// Finally, this function outputs the result returned.
void bodyMassIndex();

//doBMI(), which has two double parameters (kilograms and meters) and returns a double (BMI).
// This function calculates the BMI, and then returns the results.
// Note: BMI is calculated as (weight (kg)) / (height (m) * height (m)).
double doBMI(double inKilograms, double inMeters);

//Add (at least) two more functions to your program that calculates something you think would be useful for your calculator
// (i.e., (1) an input function with no parameters and no return value and (2) a calculation function with at least one parameter used in the calculation).
// Make this function accessible from your menu() function and test it completely.
void inchesToCentimeters();

double doInchesToCM(double inInches);

