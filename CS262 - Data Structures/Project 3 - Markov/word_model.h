/*
   CSCI 262 Data Structures, Fall 2019, Project 4 - Markov

   Author: Nicholas McClellan

   Modified: 10/24/2019
*/
#ifndef _WORD_MODEL_H
#define _WORD_MODEL_H

#include "model.h"

using namespace std;

class word_model : public markov_model {
public:
    virtual void initialize(string text, int order);

    virtual string generate(int size);


private:
    // Add any variables you may need here
    //map for each word and their following words
    map<vector<string>, vector<string>> wordMap;
    //initial seed found in initialize
    vector<string> _seed;
};

#endif
