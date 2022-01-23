//
// Created by Admin on 2019-04-25.
//

#ifndef L8D_GODZILLA_H
#define L8D_GODZILLA_H


#include <string>
#include <iostream>
using namespace std;

class Godzilla {
public:     //Public = operations/functions that a user can perform on an object

    //Pre-defined constructor
    Godzilla();
    //Parameterized constructor
    Godzilla (string desiredName, double desiredHealth, double desiredPower);

    //Public functions
    void attack (Godzilla &);

    //Public variables
    string getName ();
    double getHealth ();
    double getPower ();

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

#endif //L8D_GODZILLA_H
