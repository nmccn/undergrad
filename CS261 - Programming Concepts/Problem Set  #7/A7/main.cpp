/*
* CSCI 261 Assignment 7: Stargate
*
* Author: Nic McClellan
*
*This program writes a new file containing only the valuable data and then plots all of the stars within said fill based on their locations and
 * brightness after being adjusted
 *
*/


#include <iostream>                             // for standard input/output
using namespace std;                            // using the standard namespace

#include <SFML/Graphics.hpp>                    // include the SFML Graphics Library
using namespace sf;//for string operations
#include <string>

//for vector operations
#include <vector>

//for file reading/writing
#include <fstream>

//string stream
#include <sstream>// using the sf namespace

int main() {
    // display "Hello, World!" -- this still appears in our Run terminal as before
    cout << "Hello, World!" << endl;

    // create a RenderWindow object
    // specify the size to be 640x640
    // set the title to be "SFML Example Window"
    RenderWindow window( VideoMode(640, 640), "Stargate" );

    //********************************************
    //  PLACE ANY FILE INPUT PROCESSING BELOW HERE
    //********************************************


        //variables for the dimension of the SFML window
        const int HEIGHT = 640;
        const int WIDTH = 640;

        //vectors for the 3 columns of data being output to terminal (x pos, y pos, and brightness)
        vector<double> xPosition;
        vector<double> yPosition;
        vector<double> sBrightness;

        //variable for the tempVect holding each line separate.
        vector<string> tempVect;

        //open both files with a fstream
        fstream dataSheet;
        dataSheet.open("stars.txt");
        fstream drawingSheet;
        drawingSheet.open("ModifiedStars.txt");

        //check to see if the input file opened
        if (dataSheet.fail()) {
            cerr << "Error opening the input file" << endl;
            dataSheet.close();
            exit(1);
        }

        //check to see if the output file opened
        if (drawingSheet.fail()) {
            cerr << "Error opening the output file" << endl;
            drawingSheet.close();
            exit(2);
        }

        //while not at the end of file, get the line and push back to a vector separating each line.
        while (!dataSheet.eof()) {
            string tempStr;
            getline(dataSheet, tempStr);
            tempVect.push_back(tempStr);
        }

        //separates the sentences by "word", and stores in another vector. Using the copy function from sstream library. A fancy copy/swap
        vector<string> split;
        for(int i = 0; i < tempVect.size(); i++) {
            istringstream iss(tempVect.at(i));
            copy(istream_iterator<string>(iss),
                 istream_iterator<string>(),
                 back_inserter(split));
        }

        //populates the original xPosition vector, creates a double from string; stod
        for(int i = 0; i < split.size(); i+=6){
            double tempX = stod(split.at(i));
            xPosition.push_back(tempX);
        }

        //updates the value to the correct coord system
        for(int i = 0; i < xPosition.size(); i++){
            xPosition.at(i) = (int)((xPosition.at(i) + 1) * WIDTH / 2);
        }

        //populates the original yPosition Vector, creates a double from string again.
        for(int i = 1; i < split.size(); i+=6){
            double tempY = stod(split.at(i));
            yPosition.push_back(tempY);
        }

        //update value to correct coord system
        for(int i = 0; i < yPosition.size(); i++){
            yPosition.at(i) = (int)((-yPosition.at(i) + 1) * HEIGHT / 2);
        }

        //populate the brightness vector using same method as above.
        for(int i = 3; i < split.size(); i+=6){
            double tempB = stod(split.at(i));
            sBrightness.push_back(tempB);
        }

        //figure out which stars are valid based on brightness.
        for(int i = 0; i < sBrightness.size(); i++){
            if(sBrightness.at(i) >= 0 && sBrightness.at(i) <= 8.0){
                drawingSheet << xPosition.at(i) << "\t" << yPosition.at(i) << "\t" << sBrightness.at(i);
                drawingSheet << endl;
            }
            else{
                break;
            }
        }

        //find the brightest star
        double brightestStar = 0;
        for(int i = 0; i < sBrightness.size(); i++){
            if(sBrightness.at(i) >= 0 && sBrightness.at(i) <= 8.0){
                if(sBrightness.at(i) > brightestStar){
                    brightestStar = sBrightness.at(i);
                }
            }
        }


        //close the file when done
        dataSheet.close();



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
        CircleShape star;
        star.setRadius(2);
        const double BRIGHTEST_STAR = brightestStar;

        for(int i = 0; i < sBrightness.size(); i++){
            if(sBrightness.at(i) >= 0 && sBrightness.at(i) <= 8.0) {
                int fillColor = (int)( ( 255.0 * sBrightness.at(i) ) / BRIGHTEST_STAR );
                star.setPosition(Vector2f(xPosition.at(i), yPosition.at(i)));
                star.setFillColor(Color(fillColor, fillColor, fillColor));
                window.draw(star);
            }
            else{
                continue;
            }
        }

        //close the drawing sheet finally
        drawingSheet.close();

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