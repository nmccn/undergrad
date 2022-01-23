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
private:
    //shape
    CircleShape _Bubble;     //Private function
    //x component of velocity
    double _xDir;        //Private variable
    //y component of velocity
    double _yDir;        //Private variable

};