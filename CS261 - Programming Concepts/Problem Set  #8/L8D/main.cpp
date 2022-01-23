/*CSCI 261 L8D: Godzilla Part III
 *
 * Chloe McCaffrey and Nic McClellan
 *
 * Fighting Godzilla and MegaGodzilla by passing objects as parameters through functions
 */

#include <iostream>     //for file input/output
#include "Godzilla.h" //for the Godzilla header file
#include <string>       //For strings
#include <cmath>        //for the use of a random number
using namespace std;

int main () {
    srand(time(0));
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

    //Displaying Godzilla's information
    Godzilla godzilla;   //Monster 1 object
    Godzilla();         //For the pre-defined Godzilla constructor
    cout << godzilla.getName() << " has health of " << godzilla.getHealth() << " and power of " << godzilla.getPower() << endl;

    //Displaying Mechagodzilla's information
    Godzilla mechagodzilla( userName, userHealth, userPower );      //For Mechagodzilla aka the parameterized constructor
    cout << mechagodzilla.getName() << " has health of " << mechagodzilla.getHealth() << " and power of " << mechagodzilla.getPower() << endl;
    cout << endl;


    godzilla.attack(mechagodzilla);

    while (godzilla.getHealth() >= 0) {
        mechagodzilla.attack(godzilla);
    }

    return 0;
}