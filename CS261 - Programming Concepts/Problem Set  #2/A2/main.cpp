/* CSCI 261 Assignment A2: Triangles
*
* Author: Nic McClellan
*
* This assignment will take input from the user and determine whether or not it is a triangle. Further, the program will
 * calculate the perimeter and area of the triangles.
*/


// For cin, cout, etc.
#include <iostream>

// This is for the use of math functions such as the square root and powers.
#include <cmath>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

//for setting precision/width etc.
#include <iomanip>

// The main function is the starting point of any C++ program
int main() {
//declaring all the individual components to the ordered pairs.
    double x1;
    double y1;
    double x2;
    double y2;
    double x3;
    double y3;

// getting all of the coordinates from user input
    cout << "Enter the coordinates for the first vertex: ";
    cin >> x1 >> y1;
    cout << "Enter the coordinates for the second vertex: ";
    cin >> x2 >> y2;
    cout << "Enter the coordinates for the third vertex: ";
    cin >> x3 >> y3;
    cout << "\n\n";

//declaring the 3 side length variables and writing the 3 distance equations
    double sideLength1;
    double sideLength2;
    double sideLength3;

    sideLength1 = sqrt((pow(x2 - x1, 2) + pow(y2 - y1, 2)));
    sideLength2 = sqrt((pow(x3 - x2, 2) + pow(y3 - y2, 2)));
    sideLength3 = sqrt((pow(x3 - x1, 2) + pow(y3 - y1, 2)));

//Setting the format of all the outputs, as well as outputting the sidelengths to the user.
    cout << fixed << setprecision(3);
    cout << "The side lengths are: " << sideLength1 << " " << sideLength2 << " " << sideLength3 << endl;

//Determining if the side lengths create a triangle, using the method described in the hints.
    if (sideLength1 + sideLength2 > sideLength3 && sideLength1 + sideLength3 > sideLength2 &&
        sideLength2 + sideLength3 > sideLength1) {
        cout << "These sides do form a triangle." << endl;
    } else {
        cout << "These sides do not form a triangle. Better luck next time!" << endl;
    }
    cout << "\n\n";

//This portion of the program will calculate the perimeter / area of a valid triangle.
    double semiPerimeter;
    double area;
    double perimeter;

    semiPerimeter = (sideLength1 + sideLength2 + sideLength3) / 2;
    area = sqrt(semiPerimeter * (semiPerimeter - sideLength1) * (semiPerimeter - sideLength2) *
                (semiPerimeter - sideLength3));
    perimeter = semiPerimeter * 2;

    if (sideLength1 + sideLength2 > sideLength3 && sideLength1 + sideLength3 > sideLength2 &&
        sideLength2 + sideLength3 > sideLength1) {
        cout << "The perimeter is " << perimeter << endl;
        cout << "The area is " << area << endl;
    } else {
        cout << " ";
    }
}