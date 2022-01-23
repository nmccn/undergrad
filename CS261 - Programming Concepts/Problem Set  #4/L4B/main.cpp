/* CSCI 261 Lab 4B: Polar to Cartesian Converter
*
* Author: Nic McClellan & Brenden Posey
*
* Prompts user for a direction, and then converts their inputs from polar <-> cartesian.
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

//polar to cartesian, using formulas, updating variables given in the argument of the function
void polarToCartesian( const double RADIAL_POL, const double ANGLE_POL, // input to the function
                   double& xCoord, double& yCoord ){                  // output from the function
    xCoord = RADIAL_POL * cos(ANGLE_POL);
    yCoord = RADIAL_POL * sin(ANGLE_POL);
    cout << "The result is: " ;
    cout << "(" << xCoord << " , " << yCoord << ")";
}

//polar to cartesian, using formulas, updating variables given in the argument of the function
void cartesianToPolar( const double X_COORD, const double Y_COORD,      // input to the function
                   double& radialPol, double& anglePol ){             // output from the function
    radialPol = sqrt(pow(X_COORD, 2) + pow(Y_COORD,2));
    anglePol  = atan(Y_COORD / X_COORD);
    cout << "The result is: ";
    cout << "(" << radialPol << " , " << anglePol << ")";
}

int main() {

    //declare variables, parameters and stopping conditions
    bool validInput = false;
    double inParam1;
    double inParam2;
    double outParam1;
    double outParam2;
    char conversionDirection = ' ';

    //introduction to the converter
    cout << "(r,θ) -> (x, y)" << endl;
    cout << "or" << endl;
    cout << "(x,y) -> (r,θ)" << endl;
    cout << "\n\n";

    //determine the direction
    do {
        cout << "What is the desired output (p) or (c) : ";
        cin >> conversionDirection;
        if (conversionDirection == 'p' || conversionDirection == 'c') {
            validInput = true;
        }
    } while (!validInput);

    //prompt the numbers that need to be converted
    cout << "Enter the values you wish to convert: ";
    cin >> inParam1 >> inParam2;
    cout << "\n";

    //if statements detecting the required function, and then calling that function using user inputs
    if (conversionDirection == 'c') {
        polarToCartesian(inParam1, inParam2, outParam1, outParam2);
    }
    if (conversionDirection == 'p') {
        cartesianToPolar(inParam1, inParam2, outParam1, outParam2);
    }
}