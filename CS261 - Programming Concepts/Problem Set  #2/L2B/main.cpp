/* CSCI 261 Lab 2B: Pretty Math Equations
* Author: Nic McClellan
*
* Editing the equations and formatting used in L2A to have a more user friendly appearance. Further, I will edit the
 *  code from L2A to make it easier to work with and have less redundant lines.
*/

// For cin, cout, etc.
#include <iostream>

//For the i/o manips
#include <iomanip>

//for other functions
#include <ios>

// This is for the use of math functions such as the square root and powers.
#include <cmath>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

//Variable declaration for the distance formula:
double d;
double x;
double y;

//Assign variables in a given equation to the correct data types in the Pv=nRT formula
const double R = 0.0821; //Gas Constant
double V;                //Volume
double n;                //Number of Moles
double T;                //Temperature
double gasPressure;      //Gas Pressure

// The main function is the starting point of any C++ program
int main() {

//Prompt the user to give decimal values for each variable above
    cout << "Enter the volume: ";
    cin >> V;
    cout << "Enter the number of moles: ";
    cin >> n;
    cout << "Enter the temperature: ";
    cin >> T;
    cout << "\n\n";

//PV=nRT equation and calculation (solved for a singular variable as assigned)
    gasPressure = (n * R * T)/V ;

//Prompt the user for the x / y locations
    cout << "Enter the x position: ";
    cin >> x;
    cout << "Enter the y location: ";
    cin >> y;
    cout << "\n\n";

//Distance formula and calculation
    d = sqrt(pow (x,2) + pow(y,2));

//Final outputs
    cout << setfill('.');
    cout << fixed;
    cout << setprecision(3);
    cout << "Equation #01" << setw(30) << "Ideal Gas Law " << "(Chemistry): " ;
    cout << setw(8) << setfill(' ') << right << gasPressure << endl;
    cout << setfill('.');
    cout << "Equation #05" << setw(35) << "Distance Formula " << left << "(Math): " ;
    cout << setw(8) << setfill(' ') << right << d << endl;

    return 0;
}