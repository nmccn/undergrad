/* CSCI 261 Lab 1B: ASCII Art Intro
 *
 * Author: Nicholas McClellan
 *
 * In the second lab, we continue to practice text outputs to the screen, but this time in the form of ASCII art.
 */

// The include section adds extra definitions from the C++ standard library.
#include <iostream> // For cin, cout, etc.

// We will (most of the time) use the standard library namespace in our programs.
using namespace std;

// Define any constants or global variables below this comment.

// Must have a function named "main", which is the starting point of a C++ program.
int main() {

    /******** INSERT YOUR CODE BELOW HERE ********/

    cout << "    *    " << endl; // Prints the top line of the tree, spaces to align the character correctly.
    cout << "   ***   " << endl; // Prints the second line of the tree, again spaces align the characters correctly.
    cout << "  *****  " << endl; // Prints third line of the tree.
    cout << " ******* " << endl; // Prints fourth line of the tree.
    cout << "   ***   " << endl; // Prints the fifth and final line of the tree.
    cout << "\n\n";
    cout << " /\\   /\\" << endl;// Prints the ears of the cat.
    cout << "   o o  " << endl;  // Prints the eyes of the cat.
    cout << "  =   =  " << endl; // Prints the whiskers of the cat.
    cout << "   ---   " << endl; // Prints the mouth of the cat.


    /******** INSERT YOUR CODE ABOVE HERE ********/

    return 0; // signals the operating system that our program ended OK.
}