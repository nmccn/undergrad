/* CSCI 261: Lab3C: Fix Loop Errors
 *
 * Author:  Nicholas McClellan
 *
 *    This program illustrates a variety of common loop errors.
 *    Fix the errors in each section.

Copyright 2017 Dr. Jeffrey Paone

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

#include <iostream>
using namespace std;

int main() {
    cout << "Welcome to Loop World" << endl;

// SECTION I: update comment below on how you fixed this section's code, and tests run
// that show loop is working properly
// FIX = I changed the loop condition from < 5 to <= 5 because the program was only summing 1-4.
// TESTS: I ran the program with the updated syntax and it output the expected value of 15.

    cout << endl;
    cout << "******************" << endl;
    cout << "Section I" << endl;
    cout << "******************" << endl;

    short sum;  // Accumulates the total
    short i;    // Used as loop control variable
    for (i = 1; i <= 5; ++i) {
        sum += i;
    }
    cout << "The sum of the numbers from 1 to 5 (inclusive) is: " << sum << endl;

// SECTION II: update comment below on how you fixed this section's code, and tests run
// that show loop is working properly
// FIX = I removed the total = 0 from the loop because it was making to total 0 each time the program ran through the loop.
// TESTS: Removing this line causes the program to sum numbers correctly. I ran with a few different total numbers/prices.

    cout << endl;
    cout << "******************" << endl;
    cout << "Section II" << endl;
    cout << "******************" << endl;

    double total;     // Accumulates total
    double price;    // Gets next price from user
    short num_items;     // Number of items
    short counter = 1;  // Loop control counter

    cout << "How many items do you have? ";
    cin >> num_items;
    cout << endl;

    while (counter <= num_items) {

        cout << "Enter the price of item " << counter << ": ";
        cin >> price;
        cout << endl;
        total += price;
        counter++;
    }
    cout << "The total price is: " << total << endl;

// SECTION III: update comment below on how you fixed this section's code, and tests run
// that show loop is working properly
// FIX = To fix this I declared new variables with type integer and added a counter to the loop. I also added the _Two to each variable in this section as
// the program was doing something strange with the variables being declared earlier in the program. There is probably a way to do this in less changes.
// TESTS: The program now sums numbers and outputs the value correctly on each run through the loop. Meanwhile produces the expected value of 10.

    cout << endl;
    cout << "******************" << endl;
    cout << "Section III" << endl;
    cout << "******************" << endl;

    cout << "I will now calculate ";
    cout << "the sum of numbers from 1 to 4 (inclusive)" << endl;

    int sumTwo = 0;
    int counterTwo = 1;

    do {
        sumTwo += counterTwo;
        cout << "Sum so far: " << sumTwo << endl;
        counterTwo++;

    } while (counterTwo <= 4);

    cout << endl << "Section III Recap" << endl;

    cout << "I calculated the sum of numbers from 1 to 4 (inclusive) as " << sumTwo << endl;


// SECTION IV: update comment below on how you fixed this section's code, and tests run
// that show loop is working properly
// FIX = Again, I renamed all the variables the have _Three to make sure they were not interfering with each other. I also made the variables type short.
// The loop conditions were also changed to have the correct syntax.
// TESTS: The program outputs the expected value of 30

    cout << endl;
    cout << "******************" << endl;
    cout << "Section IV" << endl;
    cout << "******************" << endl;

    cout << "I will now calculate ";
    cout << "the sum of squares from 1 to 4 (inclusive)" << endl;

    short sumThree;
    short j;
    for (j=1; j<=4; j++) {
        sumThree += j*j;

    }

    cout << "The sum of squares from 1 to 4 is: " << sumThree << endl;

// SECTION V: update comment below on how you fixed this section's code, and tests run
// that show loop is working properly
// FIX = I moved the counter to inside of the loop, and i changed the condition to represent what the statement said the program was doing.
// I also added _Four to all the variables to avoid any problems.
// TESTS: The program outputs the expected value of 100, the original 225 had something to do with earlier variables sum and a problem of scope.e

    cout << endl;
    cout << "******************" << endl;
    cout << "Section V" << endl;
    cout << "******************" << endl;

    cout << "I will now calculate ";
    cout << "the sum of cubes from 1 to 4 (inclusive)" << endl;

    short sumFour;
    short counterFour = 1;

    while (counterFour <= 4) {
        sumFour += (counterFour * counterFour * counterFour);
        counterFour++;

    }
    cout << "The sum of cubes from 1 to 4 is: " << sumFour << endl;

    cout << endl;
    cout << "******************" << endl;
    cout << "Section Done" << endl;
    cout << "******************" << endl;

    cout << endl << "Congrats!  You fixed them all (hopefully correctly!)" << endl << endl << "Goodbye" << endl << endl;

    return 0;
}
