/*
   CSCI 262 Data Structures, Fall 2019, Project 4 - Markov

   Author: Nicholas McClellan

   Modified: 10/24/2019
*/

#include "map_model.h"

void map_model::initialize(string text, int order) {
    //text is the actual text after being read in from the file, such that all of the excess whitespace is removed, only the space between characters.
    //string of letters to generate a key in our map
    string tempKey;
    //This is potentially an issue, I am really not certain of the wrapping in the examples.
    //first character in the string;
    char firstChar = text.at(0);

    //iterate through the entire text and check for next letters
    for(int i = 0; i + order < text.size(); i++){
        //the scenario where we need to wrap around
        if(i + order + 1 > text.size()){
            tempKey = text.substr(i, order);
            //hopefully wrapping around
            letterMap[tempKey].push_back(firstChar);
        }
        else {
            //create a substring that starts at i and is of length order.
            tempKey = text.substr(i, order);
            //this gets a single character following the temp key.
            letterMap[tempKey].push_back(text.at(i + order));
        }
    }

    ////This part initializes the starting seed as well///
    //Find the index randomly for our first seed.
    int index = rand() % text.size() - order;
    //generate string of size order starting at the randomly selected index.
    _seed = text.substr(index, order);
}


string map_model::generate(int size) {
    //string for the output
    string outputString;
    //getting the first seed from member variable
    string seed = _seed;

    //generate text while the outputString is less than the size, then return the outputString
    //while the size and the next character is less than the desired size.
    while(outputString.size() < size){
        //find the seed
        auto it = letterMap.find(seed);
        //select an index in the the vector
        int index = rand() % it->second.size();
        //add the randomly selected letter to the output string
        char nextChar = it->second.at(index);
        outputString += nextChar;
        //change the seed
        seed = seed.substr(1) + nextChar;
    }
    return outputString;
}
