/*
   Project 4 - Markov

   Author: Nicholas McClellan

   Modified: 10/24/2019
*/

#include "word_model.h"

void word_model::initialize(string text, int order) {
    //Again, text is the actual text after being read in from the file, such that all of the whitespace, etc, is removed.
    //vector to hold words to use as the key in our map
    vector<string> tempKey;
    //temp vector to transition from string to vector of words, then to a map (Can most certainly be avoided)
    vector<string> tempVec;
    //string for temp word to pushback to the key / vector
    string tempWord;

    //string stream to get each word easily (converting the string of words into a vector of every word)
    stringstream separateWords(text);
    while (!separateWords.eof()) {
        separateWords >> tempWord;
        tempVec.push_back(tempWord);
    }

    //string for the first ever word (used for wrapping)
    string firstWord = tempVec.at(0);

    //populating the very first key
    for (int i = 0; i < order; i++) {
        tempKey.push_back(tempVec.at(i));
    }

    //iterating thru the remaining words
    for (int i = order; i + order < tempVec.size(); i++) {
        if (i + order + 1 > tempVec.size()) {
            wordMap[tempKey].push_back(firstWord);
        } else {
            //push the next word to the respective key
            wordMap[tempKey].push_back(tempVec.at(i));
            //erase the first element in the key
            tempKey.erase(tempKey.begin(), tempKey.begin() + 1);
            //push back the new word
            tempKey.push_back(tempVec.at(i));
        }
    }

    //generate random seed
    //create an iterator at the start of the map
    auto iterator = wordMap.begin();
    //advance a random amount of times
    advance(iterator, rand() % wordMap.size());
    //set the seed to this random vector;
    _seed = (iterator->first);

}

string word_model::generate(int size) {
    //string for the final output
    string outputString;
    //vector for the seed initialized above
    vector<string> seed = _seed;
    //string for temp word
    string tempWord;
    //generate text while the outputString is less than the size, then return the outputString
    //while the size and the next character is less than the desired size.
    while(outputString.size() < size){
        //find the seed;
        auto it = wordMap.find(seed);
        //select an index in the vector
        int index = rand() % it->second.size();
        //add the randomly selected word to the output string
        tempWord = it->second.at(index);
        outputString += tempWord + " ";
        //change the seed
        seed.erase(seed.begin(), seed.begin()+1);
        seed.push_back(tempWord);
    }
    return outputString;
}