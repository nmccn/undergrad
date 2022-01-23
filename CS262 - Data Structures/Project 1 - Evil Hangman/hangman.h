#ifndef _HANGMAN_H
#define _HANGMAN_H

/*
    hangman.h
        
    Class definition for the hangman class.

    assignment: CSCI 262 Project - Evil Hangman        

    author: 

    last modified: 9/24/2017
*/

#include <string>
#include <map>
#include <vector>
#include <fstream>
#include <iostream>
#include <string>
#include <cstdlib>
#include <cctype>
#include <algorithm>

using namespace std;

/******************************************************************************
   class hangman

   Maintains game state for a game of hangman.

******************************************************************************/

class hangman {
public:
    hangman();

    // start a new game where player gets num_guesses unsuccessful tries
	void start_new_game(int num_guesses, int word_length, bool show_word_count);

    // player guesses letter c; return whether or not char is in word
    bool process_guess(char c);

    // display current state of word - guessed characters or '-'
    string get_display_word();

    // How many guesses remain?
	int get_guesses_remaining();

    // What characters have already been guessed (for display)?
    string get_guessed_chars();

    // Has this character already been guessed?
    bool was_char_guessed(char c);

    // Has the game been won/lost?  (Else, it continues.)
    bool is_won();
    bool is_lost();

    // Return the true hidden word.
    string get_hidden_word();

    //map for the key and all words being read in from dictionary
    map<int, vector<string>> viableLengths;
    //map for the words to be broken up by families
    map<vector<int>, vector<string>> wordFamily;
    //temp string to push into the map
    string word;
    //vector that temporarily holds the biggest selection of words
    vector<string> possibleWords;



private:
    int _guesses;
    int _length;
    bool _display;
    bool _is_won;
    bool _is_lost;
    string _guessedChars;
    string _visibleword;
    string _lastWord;
};

#endif
