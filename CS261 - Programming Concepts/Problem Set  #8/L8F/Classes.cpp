//
// Created by Admin on 2019-04-27.
//

#include "Classes.h"


using namespace std;

//Default Date constructor
Date::Date() {
    setDate(30, 12, 1950);
    cout << _month << "/" << _day << "/" << _year << " is Bjarne Stroustrup's birthday! ";
    cout << "Bjarne Stroustrup is the Danish computer scientist that developed C++!" << endl;
}

//Parameterized Date constructor
Date::Date(int userDay, int userMonth, int userYear) {
    bool dateIsValidated = validate(userDay, userMonth, userYear);
    if (dateIsValidated == true) {
        setDate(userDay, userMonth, userYear);
    } else {
        setDate(30, 12, 1950);
    }
    cout << "8/1/1876 is the day when Colorado became the 38th state to join the Union!" << endl;
    cout << endl;
}

//Validation function
bool Date::validate(int theDayToCheck, int theMonthToCheck, int theYearToCheck) {
    bool proceed = true;
    if (theDayToCheck < 0 || theDayToCheck > 31) {
        proceed = false;
    } else if (theMonthToCheck < 1 || theMonthToCheck > 12) {
        proceed = false;
    } else if (theYearToCheck < 0) {
        proceed = false;
    }
    return proceed;
}

//Determining if the callee or target dates are later/earlier
void Date::timeline(Date &target) {
    if (target.getYear() > _year) {
        cout << target.getMonth() << "/" << target.getDay() << "/" << target.getYear() << " is after ";         //Cont. on next line
        cout << _month << "/" << _day << "/" << _year << "." << endl;
    } else if (target.getYear() < _year) {
        cout << target.getMonth() << "/" << target.getDay() << "/" << target.getYear() << " is before ";         //Cont. on next line
        cout << _month << "/" << _day << "/" << _year << "." << endl;
    } else if (target.getYear() == _year && target.getMonth() > _month) {
        cout << target.getMonth() << "/" << target.getDay() << "/" << target.getYear() << " is after ";         //Cont. on next line
        cout << _month << "/" << _day << "/" << _year << "." << endl;
    } else if (target.getYear() == _year && target.getMonth() < _month) {
        cout << target.getMonth() << "/" << target.getDay() << "/" << target.getYear() << " is before ";         //Cont. on next line
        cout << _month << "/" << _day << "/" << _year << "." << endl;
    } else if (target.getYear() == _year && target.getMonth() == _month && target.getDay() > _day) {
        cout << target.getMonth() << "/" << target.getDay() << "/" << target.getYear() << " is after ";         //Cont. on next line
        cout << _month << "/" << _day << "/" << _year << "." << endl;
    } else if (target.getYear() == _year && target.getMonth() == _month && target.getDay() < _day){
        cout << target.getMonth() << "/" << target.getDay() << "/" << target.getYear() << " is before ";         //Cont. on next line
        cout << _month << "/" << _day << "/" << _year << "." << endl;
    } else {
        cout << target.getMonth() << "/" << target.getDay() << "/" << target.getYear() << " is the same as ";         //Cont. on next line
        cout << _month << "/" << _day << "/" << _year << "." << endl;
    }
}

//Setter for determining the day
void Date::setDate(int desiredDay, int desiredMonth, int desiredYear) {
    _day = desiredDay;
    _month = desiredMonth;
    _year = desiredYear;
}

//Getter function for the day
int Date::getDay() const {
    return _day;
}

//Getter function for the month
int Date::getMonth() const {
    return _month;
}

//Getter function for the year
int Date::getYear() const {
    return _year;
}


//Default constructor
Event::Event() {
    //Date date;
    //date.setDate(30, 12, 1950);
    setTitle("Bjarne Stroustrup's birthday");
    setLocation("Aarhus, Denmark");
    print(_date);
}

//Parameterized constructor
Event::Event(Date& date, string titleWanted, string locationWanted) {
    _date = date;
    setTitle(titleWanted);
    setLocation(locationWanted);
    print(_date);
}

Date Event::getDate() {
    return _date;
}

string Event::getTitle() {
    return _title;
}

string Event::getLocation() {
    return _location;
}


void Event::setTitle(string desiredTitle) {
    _title = desiredTitle;
}

void Event::setLocation(string desiredLocation) {
    _location = desiredLocation;
}

//Print function
void Event::print(Date &date) const {
    cout << date.getMonth() << "/" << date.getDay() << "/" << date.getYear() << ": " <<  _title << " (" << _location << ")" << endl;
}

