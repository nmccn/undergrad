/*
   CSCI 262 Data Structures, Fall 2019, Project 4 - Markov

   Author: Nicholas McClellan

   Modified: 10/24/2019
*/
#ifndef _MAP_MODEL_H
#define _MAP_MODEL_H


#include "model.h"

using namespace std;

class map_model : public markov_model {
public:
    virtual void initialize(string text, int order);

    virtual string generate(int size);

/*  //I don't believe this was required to be implemented
    string to_string();
*/

protected:
    // Add any variables you may need here
    //map for the actual letters and their following letters / frequencies
    map<string, vector<char>> letterMap;
    //initial seed to be found in initialize
    string _seed;
};

#endif
