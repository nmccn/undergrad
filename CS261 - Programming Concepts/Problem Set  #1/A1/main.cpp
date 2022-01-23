/* CSCI 261 Assignment 1: Hello World and ASCII Art
 *
 * Author: Nicholas McClellan
 *
 * The first assignment of the year is to create an ASCII art smiley face as well as print to the screen a few things
 * about yourself
 */

// The include section adds extra definitions from the C++ standard library.
#include <iostream> // For cin, cout, etc.

// We will (most of the time) use the standard library namespace in our programs.
using namespace std;

// Define any constants or global variables below this comment.

// Must have a function named "main", which is the starting point of a C++ program.
int main() {


//The Smiley Face will be broken down by line below
cout << "     @@@     " << endl;
cout << "  @@@@@@@@@  " << endl;
cout << " @|       |@ " << endl;
cout << "@|  o   o  |@" << endl;
cout << " |    -    | " << endl;
cout << " \\  \\___/  / " << endl;
cout << "  |_______|  " << endl;
cout <<  "\n\n";

int myAge = 22;
double myGPA = 3.5;
int myDogs = 2;

cout << "Hello World!" << endl;
cout << "I am " << myAge << " years old." << endl;
cout << "My GPA is " << myGPA << "." << endl;
cout << "I have " << myDogs << " dogs at home." << endl;
cout << "Thank you, goodbye!" << endl;





    return 0; // signals the operating system that our program ended OK.
}

