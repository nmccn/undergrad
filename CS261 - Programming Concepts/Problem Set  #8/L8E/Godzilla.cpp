//
// Created by Admin on 2019-04-25.
//

#include <iostream>
#include <string>
#include "Godzilla.h"
#include <cmath>
using namespace std;


Godzilla::Godzilla() {
    setName("Godzilla");
    setPower(rand() % 15 + 10);
    setHealth(rand() % 50 + 50);
}

//Working with the Godzilla parameter defined constructor
Godzilla::Godzilla (string desiredName, double desiredHealth, double desiredPower ) {       //Parameterized constructor
    setName(desiredName);

    if (desiredHealth <= 0) {               //Resetting to health to a random value if the user inputs a value less than 1
        //health = rand() % 50 + 50;
        setHealth(rand() % 50 + 50);
    } else {
        setHealth(desiredHealth);
    }

    if (desiredPower <= 0) {               //Resetting the power to a random value if the user inputs a value of less than 1
        //power = rand() % 15 + 10;
        setPower(rand() % 15 + 10);
    } else {
        setPower(desiredPower);
    }
}

void Godzilla::attack(Godzilla &target) {
    target.setHealth(target.getHealth() - _power);
    cout << _name << " attacks " << target.getName() << endl;

    if (target.getHealth() < 0) {
        cout << target.getName() << " has been vanquished!" << endl;
    }
}

void Godzilla::greet(Godzilla &target) const {
    cout << _name << " bows to " << target.getName() << endl;
}

string Godzilla::setName(string desiredNameValue) {
    _name = desiredNameValue;
}

double Godzilla::setHealth(double healthValue) {
    _health = healthValue;      //Setting Godzilla's health to a random value between 50 and 100
}

double Godzilla::setPower(double powerValue) {
    _power = powerValue;       //Setting Godzilla's power to a random value between 10 and 25
}

string Godzilla::getName () const {
    return _name;
}

double Godzilla::getHealth () const {
    return _health;
}

double Godzilla::getPower () const {
    return _power;
}