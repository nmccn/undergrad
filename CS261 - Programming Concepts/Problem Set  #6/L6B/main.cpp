/* CSCI 261 Lab 6B: Vector of Words
*
* Author: Nic McClellan
*
*
* This program will use various vector functions and string functions to take user inputs as sentences and store them as words in a vector.
*/

// For cin, cout, etc.
#include <iostream>

// The standard namespace library, used here to avoid std:: throughout the program
using namespace std;

// for line manipulations
#include <iomanip>

//for string operations
#include <string>

//for vector operations
#include <vector>

//A couple functions from L6A are useful and will be included again below.

// Returns the first word, given a sentence
string firstWord(const string STR){
    string str = STR;
    string str2 = "";
    int IDX = str.find(" ");
    if(str.find(" ") == str.npos){
        str2 = str;
    }
    else {
        str2 = str.substr(0, IDX);
    }
    return str2; // stub
}

// Returns the string with the first word removed
string removeFirstWord(const string STR)  {
    string str = STR;
    int IDX = str.find(" ");
    if(str.find(" ") == str.npos){
        str = "";
    }
    else{
        str = str.substr(str.find_first_of(" ")+1);
    }
    return str; // stub
}

// Returns the nth word, given a sentence
string nthWord(const string STR, const int N)  {
    string str = STR;
    for(int i = 1; i < N; i++) {
        str = removeFirstWord(str);
    }
    str = firstWord(str);
    return str; // stub
}

//calculates the number of words. (this function does work)
int findNumberOfWords(const string& STR){
    //variables for the user's sentence and the counter for the number of words.
    string userInput = STR;
    //variable starts at 1 to account for the first word that does not have a space before it. Could probably do this in better ways.
    //works consistently for sentences entered as shown on the instructions.
    int numberOfWords = 1;

    //checks number of words, this will ultimately break if things like tabs and newlines are added.
    for(int i = 0; i < userInput.length(); i++){
        //checks if current index is a whitespace and that the next character is also not a white space, as this would not indicate a new word.
        if(userInput.at(i) == ' ' && userInput.at(i+1) != ' '){
            numberOfWords += 1;
        }
    }
    return numberOfWords;
}

int main (){

    //variables for the sentence and vector holding individual words. Also the number of words in the vector stored as an integer.
    string userInput;
    vector<string> userWords;

    //prompting the user
    cout << "Hey! Witness my first vector mojo!" << endl;
    cout << "Enter a sentence: " << endl;

    //getting user input and storing string
    getline(cin, userInput);
    cout << "\n";

    //Prelimary function that finds number of words from the string to act as the stopping conditions for future loops.
    int upperBound = findNumberOfWords(userInput);

    //for loop to take from nth word to a vector at that index.
    for(int i = 0; i < upperBound; i++){
        userWords.push_back(nthWord(userInput, i+1));
    }

    //TO MEET FUNCTIONAL REQUIREMENTS.
    //outputs number of words found by using a vector op .size()
    cout << "So awesome! You entered " << userWords.size() << " words. They are:" << endl;

    //for loop to print the contents of the vector
    for(int i = 0; i < upperBound; i++){
        cout << i+1 << ": " << userWords.at(i) << endl;
    }

    //TO MEET FUNCTIONAL REQUIREMENTS.
    //This finds first/last word using .at and the lower and upper bounds (adjusting for the 0 index)
    cout << "First word: " << userWords.at(0) << endl;
    cout << "Last  word: " << userWords.at(upperBound-1) << endl;
    cout << "Gaze at my awesome." << endl;

    return 0;
}

