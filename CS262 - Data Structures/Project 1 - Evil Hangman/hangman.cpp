/*
    hangman.cpp

    Method implementations for the hangman class.

    assignment: CSCI 262 Project - Evil Hangman

    author:

    last modified: 3/7/2019
*/

#include "hangman.h"

using namespace std;

// constructor
hangman::hangman() {
    //Opening dictionary file
    ifstream words("dictionary.txt");
    if (!words) {
        cerr << "Error opening dictionary.txt, exiting." << endl;
        exit;
    }
    //Reading the words in and adding the words of correct size to the map
    while (!words.eof()) {
        getline(words, word);
        int key = word.size();
        viableLengths[key].push_back(word);
    }
    //Close the dictionary file
    words.close();
}


// start_new_game()
//
// Setup a new game of hangman.
void hangman::start_new_game(int num_guesses, int word_length, bool show_word_count) {
    _guesses = num_guesses;
    _length = word_length;
    _display = show_word_count;
    _is_won = false;
    _is_lost = false;
    wordFamily.clear();
    word.clear();
    possibleWords.clear();
    _visibleword.clear();
    _guessedChars.clear();

    //populate string with - for each letter of the word to display
    for(int i = 0; i < _length; i++){
        _visibleword += "-";
    }

    //populate the key _length (an index not possible?) to all of the words of the given length.
    bool populate = true;
    while(populate) {
        for (int i = 0; i < viableLengths[_length].size(); i++) {
            wordFamily[{_length}].push_back(viableLengths[_length].at(i));
        }
        populate = false;
    }
}


// process_guess()
//
// Process a player's guess - should return true/false depending on whether
// or not the guess was in the hidden word.  If the guess is incorrect, the
// remaining guess count is decreased.
bool hangman::process_guess(char c) {
    vector<int> tempVec;
    vector<int> tempVec2;
    int counter = 1;

    //if the last word?
    if(wordFamily[{_length}].size() == 1){
        _lastWord = wordFamily[{_length}].at(0);
    }

    //Partition words into families
    //for each word
    if(wordFamily[{_length}].size() >= 1) {
        for (int i = 0; i < wordFamily[{_length}].size(); i++) {
            //reset the key
            tempVec.clear();
            //for each letter in the word
            for (int j = 0; j < _length; j++) {
                //if the letter is the characters guess
                if (wordFamily[{_length}].at(i).at(j) == c) {
                    //push back the index to the vector (key)
                    tempVec.push_back(j);
                }
            }
            //after the key is generated, insert the word at that key and delete the word from the original set.
            wordFamily[tempVec].push_back(wordFamily[{_length}].at(i));
        }
    }

    //deleting the words from _length that have the letter (unless it makes the vector empty)
    if(wordFamily[{_length}].size() > 1) {
        for (int i = 0; i < wordFamily[{_length}].size(); i++) {
            if (find(wordFamily[{_length}].at(i).begin(), wordFamily[{_length}].at(i).end(), c) !=
                wordFamily[{_length}].at(i).end()) {
                wordFamily[{_length}].erase(wordFamily[{_length}].begin() + i);
                i--;
            }
        }
    }

    //find the most common word family.
    //iterate through the map and use the .size() from vector to compare sizes
    for (auto it = wordFamily.begin(); it != wordFamily.end(); it++) {
        tempVec = it->first;
        //if the count of that key is higher than the counter (1)
        if (wordFamily[tempVec].size() > counter) {
            //set to the new counter
            counter = wordFamily[tempVec].size();
            tempVec2 = tempVec;
        }
    }

    //temp vector for the words in the biggest bucket?
    for (int i = 0; i < wordFamily[tempVec2].size(); i++) {
        possibleWords.push_back(wordFamily[tempVec2].at(i));
    }

    wordFamily.clear();
    wordFamily[{_length}] = possibleWords;
    possibleWords.clear();

    //display size
    if(_display) {
        cout << "Words in chosen family: " << wordFamily[{_length}].size() << endl;
        cout << endl;
    }

    //if the most common word family (_length) has the letter, add the letter and its positions to the displayed word
    if(wordFamily.empty()){
        _is_won = true;
        return true;
    }

    else if (find(wordFamily[{_length}].at(0).begin(), wordFamily[{_length}].at(0).end(), c) !=
        wordFamily[{_length}].at(0).end()) {
        for (int i = 0; i < wordFamily[{_length}].size(); i++) {
            for (int j = 0; j < _length; j++) {
                if (wordFamily[{_length}].at(i).at(j) == c) {
                    _visibleword.at(j) = c;
                }
            }
        }
        return true;
    }

    else if(get_display_word() == _lastWord){
        _is_won = true;
        return true;
    }

    else{
        _guesses--;
        return false;
    }
}

// get_display_word()
//
// Return a representation of the hidden word, with unguessed letters
// masked by '-' characters.
string hangman::get_display_word() {
    return _visibleword;
}


// get_guesses_remaining()
//
// Return the number of guesses remaining for the player.
int hangman::get_guesses_remaining() {
    return _guesses;
}


// get_guessed_chars()
//
// What letters has the player already guessed?  Return in alphabetic order.
string hangman::get_guessed_chars() {
    sort(_guessedChars.begin(), _guessedChars.end());
    return _guessedChars;
}


// was_char_guessed()
//
// Return true if letter was already guessed.
bool hangman::was_char_guessed(char c) {
    for(char x: _guessedChars){
        if(x == c) {
            return true;
        }
    }
    _guessedChars += c;
    return false;
}


// is_won()
//
// Return true if the game has been won by the player.
bool hangman::is_won() {
    if(_guesses >= 0 && _visibleword == get_hidden_word()){
        _is_won = true;
    }
    else{
        _is_won = false;
    }
    return _is_won;
}


// is_lost()
//
// Return true if the game has been lost.
bool hangman::is_lost() {
    if(_guesses == 0 && !_is_won){
        _is_lost = true;
    }
    else{
        _is_lost = false;
    }
    return _is_lost;
}


// get_hidden_word
//
// Return the true hidden word to show the player.
string hangman::get_hidden_word() {
    if(wordFamily.empty()){
        return _lastWord;
    }
    else{
        return wordFamily[{_length}].at(rand() % wordFamily[{_length}].size());
    }
}