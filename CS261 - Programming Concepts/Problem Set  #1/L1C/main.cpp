/* CSCI 261 Lab 1C: Geometric Calculation
 *
 * Author: Nicholas McClellan
 *
 * This lab involves gathering dimensions from input statements and using them to calculate things such as volume/area
 */

// The include section adds extra definitions from the C++ standard library.
#include <iostream> // For cin, cout, etc.

// We will (most of the time) use the standard library namespace in our programs.
using namespace std;

// Must have a function named "main", which is the starting point of a C++ program.
int main() {


//Assign all variables to integers as stated in the problem.
    int length;
    int width;
    int height;
    int volume;

//Prompt the user to give the dimensions of a box, while also telling them to use integer values.
    cout << "Enter integer values for the dimensions of the box: ";

//Where the user inputs are being recorded.
    cin >> length >> width >> height;

// Volume of a box is length times width times height.
    volume = length * width * height;

// Output the volume based upon the above formula and user given dimensions.
    cout << "The volume of the box with the given dimensions is: " << volume << endl;

//Assign variables for determining the area of a circle.
    double radius;
    double area;
    const double PI = 3.14159;

//Prompt the user to give the radius of the circle.
    cout << "Enter a decimal value for the radius of the circle: ";

//Where the user inputs are gathered
    cin >> radius;

//Calculating the area of the circle
    area = radius * radius * PI;

//Outputting the area of the circle to the screen
    cout << "The area of a circle with radius " << radius << " is: " << area << endl;

    return 0; // signals the operating system that our program ended OK.
}
