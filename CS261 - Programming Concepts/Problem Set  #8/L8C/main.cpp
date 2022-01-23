/*CSCI 261: Bouncing Bubble
 *
 * Chloe McCaffrey & Nicholas McClellan
 *
 *Making a bubble bounce around the screen
 */

#include <iostream>
#include "Bubble.h"
using namespace std;

#include <SFML/Graphics.hpp>
using namespace sf;

int main() {
    //Making a single instance of a bubble object with the parameterized constructor (contains initial x and y velocity)
    Bubble myBubble(1,2);

    RenderWindow windowDisplay( VideoMode(640, 640), "Bubble SFML window" );

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

        //Drawing the bubble using the getCircle function
        windowDisplay.draw(myBubble.getCircle());

        //Updating the position of the bubble with the x/y "Velocity" vectors


        //if statements that will determine if the shape is off the screen, and if so, will have the bubble bounce back.
        //reverse if it hits right hand wall
        if(myBubble.getPosition().x + 50 > 640){
            myBubble.setXDir(myBubble.getXDir() * -1);
        }
        //reverse if it hits the left hand wall
        if(myBubble.getPosition().x < 0) {
            myBubble.setXDir(myBubble.getXDir() * -1 );
        }
        //reverse if it hits the top wall
        if(myBubble.getPosition().y + 50 > 640){
            myBubble.setYDir(myBubble.getYDir() * -1);
        }//reverse if it hits the bottom wall
        if(myBubble.getPosition().y < 0) {
            myBubble.setYDir(myBubble.getYDir() * -1);
        }

        //finally updates the bubbles position
        myBubble.updatePosition();
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
        }
    }

    return EXIT_SUCCESS;                        // report our program exited successfully
}