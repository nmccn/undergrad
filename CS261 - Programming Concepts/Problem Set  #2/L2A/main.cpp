/* CSCI 261 Lab 2A: Math Equations
*
* Authors: Chloe McCaffrey and Nic McClellan
*
* Pair programming to write a code to solve for distance and the Ideal Gas Law.
*/




// For cin, cout, etc.
#include <iostream>

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




// The main function is the starting point of any C++ program
int main() {


    //Prompt the user to give decimal values for each variable above
    cout << "This segment of the program will solve for pressure using the equation PV = nRT." << endl;
    cout << "Enter the decimal values for volume: " << endl;
    cin >> V;
    cout << "You entered " << V << "." << endl;
    cout << "" << endl;
    cout << "Enter the decimal value for the number of moles: " << endl;
    cin >> n;
    cout << "You entered " << n << " as the number of moles" << endl;
    cout << "" << endl;
    cout << "Enter the decimal value for the temperature" << endl;
    cin >> T;
    cout << "You entered " << T << " as the temperature." << endl;
    cout << "" << endl;


    // PV=nRT equation and calculation
    double gasPressure = (n * R * T)/V ;

    // Output the volume based upon the above formula and user given dimensions.
    cout << "The pressure within the given system is: " << gasPressure << endl;
    cout << "" << endl;
    cout << "" << endl;

    //x variable input:
    cout << "Now, we are going to determine what the distance between two points is." << endl;
    cout << "" << endl;
    cout << "When making a triangle, what is the distance of the decimal value of x?" << endl;
    cin >> x;
    cout << "You entered " << x << " as the length of x." << endl;
    cout << "" << endl;

    //y variable input:
    cout << "What is the decimal length of y? " << endl;
    cin >> y;
    cout << "You entered " << y << " as the length of y." << endl;
    cout << "" << endl;

    //distance formula
    d = sqrt( pow (x,2)+ pow (y,2));
    cout << "The distance is " << d << endl;

    return 0;
}