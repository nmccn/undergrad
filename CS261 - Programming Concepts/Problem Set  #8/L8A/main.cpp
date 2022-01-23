/*CSCI 261 L8A: Godzilla
 *
 * Chloe McCaffrey and Nic McClellan
 *
 * Introduction to Godzilla and MegaGodzilla using classes
 */

#include <iostream>     //for file input/output
#include "Godzilla.h"  //for the Godzilla header file
#include <string>       //For strings
#include <cmath>        //for the use of a random number
using namespace std;

int main () {
    srand(time(0));       //Setting the seed for randomization
    string userName;
    double userHealth;
    double userPower;

    //Assigning a name to the Mechagodzilla object
    cout << "Please enter a name for your creature: " << endl;
    cin >> userName;

    //Getting health information for the Mechagodzilla object
    cout << "Now please enter a health value for " << userName << " that is greater than zero and less than 100: " << endl;
    cin >> userHealth;

    //Getting power information for the Mechagodzilla object
    cout << "Now please enter a power value for " << userName <<  " that is greater than zero and less than 25: " << endl;
    cin >> userPower;
    cout << endl;

    Godzilla();     //For the pre-defined constructor
    Godzilla monster1;
    cout << monster1.name << " has health of " << monster1.health << " and power of " << monster1.power << endl;

    Godzilla monster2( userName, userHealth, userPower );      //For Mechagodzilla aka the parameterized constructor
    cout << monster2.name << " has health of " << monster2.health << " and power of " << monster2.power << endl;

    return 0;
}