/*CSCI 261: Bouncing Bubble
 *
 * Nicholas McClellan
 *
 * Adding more functionality to the Bouncing Bubble lab, more specifically things like drawing multiple more sporadic bubbles,
 * as well as allowing users to add/remove bubbles with key presses.
 */

#include <iostream>
#include "Bubble.h"
#include <vector>
#include <ctime>
#include <SFML/Graphics.hpp>
using namespace sf;
using namespace std;

int main() {
    //seed random time 0
    srand(time(NULL));

    //vector of bubbles to be drawn later
    vector<Bubble> bubsDisplayed;

    //populating vector after randomizing color/radius/position for bubbles
    for(int i = 0; i < 5; i++) {
        //parameterized constructor randomizing the x/y velocity, using 25 due to % not accepting doubles
        Bubble tempBub((double)(rand() % 25) / 10, (double)(rand() % 25) / 10);
        //using member functions to set the already mentioned variables.
        tempBub.setBubColor(rand() % 255, rand() % 255, rand() % 255);
        tempBub.setBubRadius(rand() % 40 + 10);
        tempBub.setPosition(rand() % 300 + 100, rand() % 300 + 100);
        bubsDisplayed.push_back(tempBub);
    }

    RenderWindow windowDisplay( VideoMode(1280, 1280), "Bubble Trouble!!" );

    //********************************************
    //  PLACE ANY FILE INPUT PROCESSING BELOW HERE
    //********************************************

    //********************************************
    //  PLACE ANY FILE INPUT PROCESSING ABOVE HERE
    //********************************************


    while( windowDisplay.isOpen() ) {
        windowDisplay.clear( Color::Black );

        //****************************************
        //  ADD ALL OF OUR DRAWING BELOW HERE
        //****************************************

        //Loop to draw all of the bubbles in the vector (used a skeleton from bouncing bubble lab.
        //changed the values to be related to the randomized variables and new screen size.
        for(int i = 0; i < bubsDisplayed.size(); i++){
            //reverse if it hits the right hand wall
            if(bubsDisplayed.at(i).getPosition().x + bubsDisplayed.at(i).getBubRadius() > 1280){
                bubsDisplayed.at(i).setXDir(bubsDisplayed.at(i).getXDir() * -1);
            }
            //reverse if it hits the left hand wall
            if(bubsDisplayed.at(i).getPosition().x < 0) {
                bubsDisplayed.at(i).setXDir(bubsDisplayed.at(i).getXDir() * -1);
            }
            //reverse if it hits the top wall
            if(bubsDisplayed.at(i).getPosition().y + bubsDisplayed.at(i).getBubRadius() > 1280){
                bubsDisplayed.at(i).setYDir(bubsDisplayed.at(i).getYDir() * -1);
            }
            //reverse if it hits the bottom wall
            if(bubsDisplayed.at(i).getPosition().y < 0) {
                bubsDisplayed.at(i).setYDir(bubsDisplayed.at(i).getYDir() * -1);
            }
            //draw and update the bubbles position based on velocity
            windowDisplay.draw(bubsDisplayed.at(i).getCircle());
            bubsDisplayed.at(i).updatePosition();
        }

        //****************************************
        //  ADD ALL OF OUR DRAWING ABOVE HERE
        //****************************************

        windowDisplay.display();                       // display the window

        //****************************************
        // HANDLE EVENTS BELOW HERE
        //****************************************
        Event event;
        while( windowDisplay.pollEvent(event) ) {      // ask the window if any events occurred
            if( event.type == Event::Closed ) { // if event type is a closed event
                // i.e. they clicked the X on the window
                windowDisplay.close();                 // then close our window
            }
            //adding the same generator from the for loop above to a click from LMB
            if(event.type == Event::MouseButtonPressed){
                if(event.mouseButton.button == Mouse::Left){
                    //parameterized constructor randomizing the x/y velocity, using 25 due to % not accepting doubles
                    Bubble tempBub((double)(rand() % 25) / 10, (double)(rand() % 25) / 10);
                    //using member functions to set the already mentioned variables.
                    tempBub.setBubColor(rand() % 255, rand() % 255, rand() % 255);
                    tempBub.setBubRadius(rand() % 40 + 10);
                    //change the position to be at mouse cursor
                    tempBub.setPosition(event.mouseButton.x, event.mouseButton.y);
                    bubsDisplayed.push_back(tempBub);
                }
            }
            if(event.type == Event::KeyPressed){
                if(event.key.code == Keyboard::D){
                    bubsDisplayed.pop_back();
                }
            }
        }
    }
    return EXIT_SUCCESS;                        // report our program exited successfully
}