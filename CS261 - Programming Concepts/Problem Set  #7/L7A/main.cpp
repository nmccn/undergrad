/*
* CSCI 261 Lab 7A: SFML Drawing.
*
* Author: Nic McClellan
*
*
* This program will be a very basic SFML drawing of a car and tree using basic shapes like rectangles and triangles.
*/


#include <iostream>                             // for standard input/output
using namespace std;                            // using the standard namespace

#include <SFML/Graphics.hpp>                    // include the SFML Graphics Library
using namespace sf;                             // using the sf namespace

int main() {
    // display "Hello, World!" -- this still appears in our Run terminal as before
    cout << "Hello, World!" << endl;

    // create a RenderWindow object
    // specify the size to be 640x640
    // set the title to be "SFML Example Window"
    RenderWindow window( VideoMode(640, 640), "SFML Example Window" );

    //********************************************
    //  PLACE ANY FILE INPUT PROCESSING BELOW HERE
    //********************************************

    //********************************************
    //  PLACE ANY FILE INPUT PROCESSING ABOVE HERE
    //********************************************

    // while our window is open, keep it open
    // this is our draw loop
    while( window.isOpen() ) {
        window.clear( Color::Black );           // clear the contents of the old frame
        // by setting the window to black

        //****************************************
        //  ADD ALL OF OUR DRAWING BELOW HERE
        //****************************************

        //rectangles for the body of the car
        RectangleShape rect1;
        rect1.setSize( Vector2f( 200, 50 ) );
        rect1.setPosition( 200, 320  );
        rect1.setFillColor( Color(139, 0, 0) );
        window.draw( rect1 );

        RectangleShape rect2;
        rect2.setSize( Vector2f( 100, 30 ) );
        rect2.setPosition( 250, 290 );
        rect2.setFillColor( Color(139, 0, 0) );
        window.draw( rect2 );

        //circles for the wheels of the car
        CircleShape circ1;
        circ1.setRadius(25);
        circ1.setPosition( 340, 340  );
        circ1.setFillColor( Color(128, 128, 128) );
        window.draw( circ1 );

        CircleShape circ2;
        circ2.setRadius( 25);
        circ2.setPosition( 210, 340  );
        circ2.setFillColor( Color(128, 128, 128) );
        window.draw( circ2 );

        //rectangle & triangle to create a tree
        RectangleShape rect3;
        rect3.setSize( Vector2f( 50, -200 ) );
        rect3.setPosition( 440, 370  );
        rect3.setFillColor( Color(139,69,19) );
        window.draw( rect3 );

        CircleShape triangle(80, 3);
        triangle.setPosition(385, 70);
        triangle.setFillColor(Color(0,100,0));
        window.draw(triangle);



        //****************************************
        //  ADD ALL OF OUR DRAWING ABOVE HERE
        //****************************************

        window.display();                       // display the window

        //****************************************
        // HANDLE EVENTS BELOW HERE
        //****************************************
        Clock clock;
        Event event;
        while( window.pollEvent(event) ) {      // ask the window if any events occurred
            if( event.type == Event::Closed ) { // if event type is a closed event
                                                // i.e. they clicked the X on the window
                window.close();                 // then close our window
            }
        }
    }

    return EXIT_SUCCESS;                        // report our program exited successfully
}