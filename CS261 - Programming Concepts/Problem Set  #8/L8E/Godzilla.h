//
// Created by Admin on 2019-04-25.
//

#ifndef L8E_GODZILLA_H
#define L8E_GODZILLA_H


#include <string>
#include <iostream>
using namespace std;

class Godzilla {
public:     //Public = operations/functions that a user can perform on an object

    //Pre-defined constructor
    Godzilla();
    //Parameterized constructor
    Godzilla (string, double, double);

    //Public functions
    void attack (Godzilla &);
    void greet (Godzilla &) const;

    //Public variables
    string getName () const;
    double getHealth () const;
    double getPower () const;

private:
    //Private variables
    string _name;
    double _health;
    double _power;

    //Private functions
    double setHealth(double);
    double setPower(double);
    string setName (string);
    bool determineIfHealthIsZero(string, int);

};


#endif //L8E_GODZILLA_H
