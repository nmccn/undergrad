//
// Created by Nicholas McClellan on 2019-04-30.
//

//
// Created by Nicholas McClellan on 2019-04-30.
//

#include "Bubble.h"
#include <iostream>

//default constructor
Bubble::Bubble(){
    _xDir = 1;
    _yDir = 2;
    CircleShape circle;
    circle.setFillColor( Color::Blue );
    circle.setRadius(50);
    circle.setPosition(150, 150);
    _Bubble = circle;
}

//parameterized constructor
Bubble::Bubble(double x, double y){
    _xDir = x;
    _yDir = y;
    CircleShape circle;
    circle.setFillColor( Color::Blue );
    circle.setRadius(50);
    circle.setPosition(150, 150);
    _Bubble = circle;
}

//setter for circle shape
void Bubble::setCircle(CircleShape bubble){
    _Bubble = bubble;
}

//getter for circle shape
CircleShape Bubble::getCircle(){
    return _Bubble;
}

//setter for xdirection
void Bubble::setXDir(double x){
    _xDir = x;
}

//getter for xdirection
double Bubble::getXDir(){
    return _xDir;
}

//setter for y direction
void Bubble::setYDir(double y){
    _yDir = y;
}

//getter for ydirection
double Bubble::getYDir(){
    return _yDir;
}

//setter (updater) for the position of bubble
void Bubble::updatePosition() {
    _Bubble.setPosition(_Bubble.getPosition().x + _xDir, _Bubble.getPosition().y + _yDir);
}

//getter for the posiiton of the bubble.
Vector2f Bubble::getPosition(){
    return _Bubble.getPosition();
}