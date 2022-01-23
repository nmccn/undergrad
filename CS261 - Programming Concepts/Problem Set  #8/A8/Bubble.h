//
// Created by Nicholas McClellan on 2019-04-30.
//

#ifndef SFML_TEMPLATE_BUBBLE_H
#define SFML_TEMPLATE_BUBBLE_H

#endif //SFML_TEMPLATE_BUBBLE_H

#include <iostream>
using namespace std;

#include <SFML/Graphics.hpp>
using namespace sf;

//class for our bubble objects
class Bubble {

    //public functions and constructors
public:
    //constructors, both default and parameter
    Bubble();
    Bubble(double x, double y);
    //getting and setter for circle shape
    void setCircle(CircleShape circle);
    CircleShape getCircle();
    //getter and setters for x & y direction vectors
    void setXDir(double x);
    double getXDir();
    void setYDir(double y);
    double getYDir();
    //getter and "setter" (updater) for the bubbles position
    void updatePosition();
    Vector2f getPosition();
    //new getters/setters for this assignment, mainly to deal with setting position/radius/color
    void setPosition(double xPos, double yPos);
    //getter above serves as a getter for this../
    void setBubRadius(int bubRadius);
    int getBubRadius();
    void setBubColor(int red, int green, int blue);

    //private variables and CircleClass shape for the bubble
private:
    //shape
    CircleShape _Bubble;
    //x component of velocity
    double _xDir;
    //y component of velocity
    double _yDir;

};