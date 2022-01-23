//
// Created by Admin on 2019-04-27.
//

#ifndef L8F_DATE_H
#define L8F_DATE_H


#include <iostream>
#include <cstdlib>
#include <string>
#include <vector>
using namespace std;


class Date {
public:

    Date();                         //Default constructor
    Date (int, int, int);           //Parameterized constructor

    //Public functions
    int getDay() const;
    int getMonth() const;
    int getYear() const;
    void timeline(Date &);
    void setDate (int, int, int);


private:

    //Private variables
    int _year;
    int _month;
    int _day;

    //Private functions
    bool validate(int, int, int);        //Validate that the imput is valid (1-12 months 1-31 days year > 0)- reset to default otherwise

};

class Event {
public:

    Event ();                             //Default constructor
    Event (Date&, string, string);        //Parameterized constructor

    void setDate(Date date);               //Setting the date
    Date getDate();
    string getTitle();
    string getLocation();

    //Private functions
    void setTitle(string);
    void setLocation(string);
    void print(Date&) const;

private:

    //Include the date class
    Date _date;
    string _title;
    string _location;
};


#endif //L8F_DATE_H
