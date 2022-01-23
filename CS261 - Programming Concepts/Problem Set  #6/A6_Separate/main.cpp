/* CSCI 261 Assignment 6: Word and Letter Counts
*
* Author: Nic McClellan
*
*
* This program will take it lines of text from the user and then it will determine the frequency of all letters in alpha. Further, it will calculate
 * which word was the most and least frequent.
*/



#include "A6_prototype.h"

int main(){
    //variables
    WordCount userLetters[26];
    vector<WordCount> countKeeper;
    vector<string> userWords;

    //getting user input, then removing spaces and punctuation.
    string userText = getUserSentence();
    inputAdjustments(userText);

    //seperating words into substrings and then sorting those substrings alphabetically.
    determineWord(userText, countKeeper);
    sortWords(countKeeper, countKeeper.size());

    //header
    cout << endl;
    cout << "Word Counts" << endl;
    cout << "-----------" << endl;

    //output words, and then find most and least frequent word and output those as well.
    outputWords(countKeeper);
    cout << endl;
    mostFrequentWord(countKeeper);
    leastFrequentWord(countKeeper);
    cout << endl;

    //header2
    cout << "Letter Counts" << endl;
    cout << "-------------" << endl;

    //find letter frequency and total letter, and then output most and least frequent letters.
    findLetterFrequency(userText, userLetters);
    cout << endl;
    mostFrequentLetter(userLetters);
    leastFrequentLetter(userLetters);
    cout << endl;

    return 0;
}