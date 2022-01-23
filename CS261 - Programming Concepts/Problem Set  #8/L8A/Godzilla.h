//
// Created by Admin on 2019-04-25.
//

#ifndef L8A_GODZILLA_H
#define L8A_GODZILLA_H


#include <string>
#include <iostream>
using namespace std;

class Godzilla {
    public:     //Public = operations/functions that a user can perform on an object
    string name;
    double health;
    double power;

    Godzilla ();       //Default constructor
    Godzilla (string desiredName, double desiredHealth, double desiredPower);
};


#endif //L8A_GODZILLA_H
