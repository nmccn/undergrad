/* CSCI 261: Fix Function Errors
 *
 * Author: Nic McClellan and Brenden Posey
 *
 *    This program illustrates a variety of common loop errors.
 *    Fix the errors in each section.

Copyright 2018 Dr. Jeffrey Paone

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

 */

#include <cstdlib>
#include <ctime>
#include <iostream>
using namespace std;

// input: integer
// output: none
// adds five to the given parameter
void addFive( int& x ) {
    x += 5;
}

//input: none
//output: a smiley face
//prints a smiley face
void printSmileyFace(){
//The Smiley Face will be broken down by line below
    cout << "     @@@     " << endl;
    cout << "  @@@@@@@@@  " << endl;
    cout << " @|       |@ " << endl;
    cout << "@|  o   o  |@" << endl;
    cout << " |    -    | " << endl;
    cout << " \\  \\___/  / " << endl;
    cout << "  |_______|  " << endl;
    cout <<  "\n";
}

// input: none
// output: a random number
int generateRandomNumber() {
    return rand() % 100;
}

// input: three integers
// output: the sum of all three parameters
int sum( int x, int y, int z ) {
    return x + y + z;
}

// input: two doubles
// output: the product of the two doubles
double multiply( double a, double b ){
    return a * b;
}

int main() {
    cout << "Welcome to Function World" << endl;

// SECTION I: update comment below on how you fixed this section's code, and tests run
// that show function is working properly
// FIX = Changed the datatype from int x to int& x as the value of x was being changed in the function, I chose to make it pass by reference.
// TESTS: I noticed the number was not updating in the output, but rather stuck at 4. Further, CLion did not like the x += 5 before making x pass by reference.
//        I think it was because originally the program was trying to redefine the variable.

    cout << endl;
    cout << "******************" << endl;
    cout << "Section I" << endl;
    cout << "******************" << endl;

    int numTrees = 4;
    cout << "There are initially " << numTrees << " trees." << endl;
    addFive( numTrees );
    cout << "We planted five trees, there are now " << numTrees << " trees." << endl;

// SECTION II: update comment below on how you fixed this section's code, and tests run
// that show function is working properly
// FIX = A function was constructed that will print a smiley face when called in main. The function is of type void above.
// TESTS: There is no printSmileyFace function, so we will have to make one. After making one, the function prints a smiley face :)

    cout << endl;
    cout << "******************" << endl;
    cout << "Section II" << endl;
    cout << "******************" << endl;

    printSmileyFace();

// SECTION III: update comment below on how you fixed this section's code, and tests run
// that show function is working properly
// FIX = Moving the seed from the function to the main function. The random seed was seeding every time the function was called,
//       this gives us the same number because it seeds it at the same instant in time.
// TESTS: The program initially prints the same random number 5 times. After changing, the program output 5 different numbers.

    cout << endl;
    cout << "******************" << endl;
    cout << "Section III" << endl;
    cout << "******************" << endl;

    srand( time(0) );
    cout << "Five different random numbers are: " << endl;
    for( int i = 0; i < 5; i++ ) {
        cout << "\t" << generateRandomNumber() << endl;
    }


// SECTION IV: update comment below on how you fixed this section's code, and tests run
// that show function is working properly
// FIX = Change the function to return x+y+z rather than x+x+x , and also add the 3rd argument to the function.
// TESTS: Initially, the program doesn't run because the function is only given 2 of the 3 arguments required. After first change
//        the program was not summing properly because the function returned x+x+x rather than x+y+z. Finally, the program sums accordingly.

    cout << endl;
    cout << "******************" << endl;
    cout << "Section IV" << endl;
    cout << "******************" << endl;

    int num1, num2, num3;
    cout << "Enter three numbers: ";
    cin >> num1 >> num2 >> num3;
    cout << "The sum of all three is " << sum( num1, num2, num3 ) << endl;

// SECTION V: update comment below on how you fixed this section's code, and tests run
// that show function is working properly
// FIX = Add the () after the function, as it was not the proper syntax of a function call prior.
// TESTS: Initially the program won't run because it claims that generateRandomNumber always is true, and this is because there was no ()
//        following the function name. After fixing that the program ran as intended.

    cout << endl;
    cout << "******************" << endl;
    cout << "Section V" << endl;
    cout << "******************" << endl;

    cout << "Another random number is " << generateRandomNumber() << endl;

// SECTION VI: update comment below on how you fixed this section's code, and tests run
// that show function is working properly
// FIX = Add the proper {} and return value to the multiply function above, as it had no function body.
// TESTS: Initially, the program would not run giving all kinds of errors surrounding the multiply function and double
//        variables doub1 and doub2.

    cout << endl;
    cout << "******************" << endl;
    cout << "Section VI" << endl;
    cout << "******************" << endl;

    double doub1, doub2;

    cout << "Enter two doubles: ";
    cin >> doub1 >> doub2;
    cout << "Their product is: " << multiply( doub1, doub2 ) << endl;

    cout << endl;
    cout << "******************" << endl;
    cout << "Section Done" << endl;
    cout << "******************" << endl;

    cout << endl << "Congrats!  You fixed them all (hopefully correctly!)" << endl << endl << "Goodbye" << endl << endl;

    return 0;
}

