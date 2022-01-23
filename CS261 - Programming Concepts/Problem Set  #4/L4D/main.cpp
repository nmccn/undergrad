/* CSCI 261: Towers of Hanoi Fix
 *
 * Author: Nic McClellan and Brenden Posey
 *
 * This progam is the Tower of Hanoi fix that went into the autograder
 *
*/

/*
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

#include <iostream>     // needed for cout, endl, & cin
using namespace std;    // so we don't have to type std::cout, std::cin, std::endl everytime

//
// towersOfHanoi()
//
//   Recursive solution to move N disks from a starting peg to a
// destination peg
//
// Params:
//   int N      - the number of disks to move
//   int start  - ID of the peg the disks are currently on
//   int target - ID of the peg the disks need to move to
//   int spare  - ID of the peg that can be used as temporary storage
//
// Return:
//   void       - returns nothing
//
// Output:
//   Outputs the series of moves to solve the problem for N disks

void towersOfHanoi( int N, int start, int target, int spare ) {
    // if there are no more disks to move, then we are done!
    if (N == 1) {
        cout << "Move disk " << N << " from " << start << " to " << target << endl;
        return;
    } else {

        // Step 1: recursively move the top N-1 disks from our current peg
        // to the non-target peg
        towersOfHanoi(N - 1, start, spare, target);

        // Step 2: move the largest disk that was on the bottom from our
        // current peg to the target peg
        cout << "Move disk " << N << " from " << start << " to " << target << endl;

        // Step 3: recursively move the remaining N-1 disks from the non-target
        // peg to our target peg on top of the largest disk we just moved
        towersOfHanoi(N - 1, spare, target, start);
    }
}


int main() {
    const int STARTING_PEG = 0;         // 0 - ID of the peg our disks start on
    const int TARGET_PEG = 1;           // 1 - ID of the peg we need to move our disks to
    const int SPARE_PEG = 2;            // 2 - ID of the peg that can be used for temp storage
    int numberOfDisks;

    cout << "Enter number of disks to solve: ";
    cin >> numberOfDisks;               // user enters the number of disks to solve for

    // solve Towers of Hanoi problem for numberOfDisks disks
    // disks are initially on our starting peg and need to move to our target peg
    towersOfHanoi( numberOfDisks, STARTING_PEG, SPARE_PEG, TARGET_PEG );

    return 0;
}


