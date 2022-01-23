//
// Created by Admin on 2019-04-25.
//

#include <iostream>
#include <string>
#include "Godzilla.h"
#include <cmath>
using namespace std;

//Working with the Godzilla pre-defined constructor
Godzilla::Godzilla() {
    name = "Godzilla";
    health = rand() % 50 + 50;      //Setting Godzilla's health to a random value between 50 and 100
    power = rand() % 15 + 10;       //Setting Godzilla's power to a random value between 10 and 25
}

//Working with the Godzilla parameter defined constructor
Godzilla::Godzilla (string desiredName, double desiredHealth, double desiredPower ) {       //Parameterized constructor
    name = desiredName;

    health = desiredHealth;
    if (desiredHealth <= 0) {               //Resetting to health to a random value if the user inputs a value less than 1
        health = rand() % 50 + 50;
    }

    power = desiredPower;
    if (desiredPower <= 0) {               //Resetting the power to a random value if the user inputs a value of less than 1
        power = rand() % 15 + 10;
    }
}
