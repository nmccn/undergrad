/*CSCI 261 L8F: Making a calendar
 *
 * Chloe McCaffrey and Nic McClellan
 *
 * Making a calendar using classes
 */

#include <string>
#include <vector>
#include <iostream>
#include "Classes.h"
using namespace std;

int main() {

    //Default constructors
    Date bjarneStroustrupBirthday;

    Event automatic;

    int userDay;
    int userMonth;
    int userYear;
    cout << endl;
    cout << "Please enter the day: " << endl;
    cin >> userDay;
    cout << "Please enter the month: " << endl;
    cin >> userMonth;
    cout << "Please enter the year: " << endl;
    cin >> userYear;
    cout << endl;

    //Parameterized date constructor
    Date newDate (userDay, userMonth, userYear);         //Need day, month, and year

    //Determining if one date is after another
    bjarneStroustrupBirthday.timeline(newDate);

    string userTitle;
    string userLocation;
    char whitespace;
    cout << "What is the title for the event? " << endl;

    //to stop from skipping straight to second getline
    cin.get(whitespace);
    getline(cin, userTitle, '\n');

    cout << "What is the location of the event? " << endl;
    getline(cin, userLocation, '\n');

    //Parameterized event constructor
    Event newEvent (newDate, userTitle, userLocation);



    return 0;
}
