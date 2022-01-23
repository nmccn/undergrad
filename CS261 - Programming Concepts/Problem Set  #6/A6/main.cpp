/* CSCI 261 Assignment 6: Word and Letter Counts
*
* Author: Nic McClellan
*
*
* This program will take it lines of text from the user and then it will determine the frequency of all letters in alpha. Further, it will calculate
 * which word was the most and least frequent.
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

using namespace std;
//struct for wordcount and words.
struct WordCount{
    string word;
    int count;
};

//function to get input from user, including prompt and stopping condition.
string getUserSentence(){
    cout << "Enter as many sentences as you like and enter \"I'm done!\" when completed:" << endl;
    //variables for the sentence of each input, and then a vector to hold all sentences.
    string userText;
    string userSentence;
    while(userSentence != "I'm done!"){
        getline(cin, userSentence);
        if(userSentence == "I'm done!"){
            break;
        }
        else {
            userText.append(userSentence);
            //to create a break between words
            userText.append(" ");
        }
    }
    return userText;
}

//function to make all adjustments to othe string, such as remove punctuation and make everything uppercase
string inputAdjustments(string& userText){
    //checks if the character at the given index is punctuation, and if it is, remove that character. Otherwise continue
    for(int i = 0; i < userText.size(); i++){
        if(ispunct(userText.at(i))){
            userText.erase(i, 1);
            //go back a step in the loop, to account for the any character being removed.
            i = i - 1;
        }
    }
    //makes all characters within usertext uppercase
    for(char &c : userText){
        c = toupper(c);
    }
    return userText;
}

//function to find unique words, and tracks how often they appear. Information is then stored in countKeeper
void findWordFrequency(string userText, vector<WordCount>& countKeeper){
    //variable for each word, only stored temporarily.
    WordCount testWord;
    //for loop to determine if the word is already contained in countKeeper (if it is a duplicate).
    for(int i = 0; i < (countKeeper).size(); i++){
        //if it is already in the vector, only increment count. do not add the word again.
        if(countKeeper.at(i).word == userText){
            countKeeper.at(i).count += 1;
            //exits the functions prematurely
            return;
        }
    }
    //if the word wasn't found in the entire vector it is added to the .word vector and the .count is started at 1.
    testWord.count = 1;
    testWord.word = userText;
    countKeeper.push_back(testWord);
}

//function that ultimately updates the countkeeper vectors by calling findWordFrequency to update counts etc.
void determineWord(string userText, vector<WordCount>& countKeeper){
    //variable for the ending index of all the substrings made
    int endingPos;
    for(int i = 0; i < userText.size(); i++){
        if (!isalpha(userText.at(i))){
            continue;
        }
        //used to iterate through the string in conjunction with i, allows to create substrings of each word
        endingPos = userText.find(" ", i);
        if (endingPos != string::npos) {
            findWordFrequency((userText.substr(i, endingPos - i)), countKeeper);
            i = endingPos;
        }
        else {
            findWordFrequency(userText.substr(i), countKeeper);
            i = userText.size();
        }
    }
}

//function to sort the words. follows a selection sort boilerplate.
void sortWords(vector<WordCount>& countKeeper, int vectorSize){
    //nested for loops iterating through each value up until the 2nd to highest one
    for(int i = 0; i < countKeeper.size()-1; i++){
        for(int j = i + 1; j < countKeeper.size(); j++){
            //swaps both the words and counts based on their order.
            if(countKeeper.at(i).word > countKeeper.at(j).word){
                swap(countKeeper.at(i).word, countKeeper.at(j).word);
                swap(countKeeper.at(i).count, countKeeper.at(j).count);
            }
        }
    }
}

//function to simply output the words and their counts
void outputWords(vector<WordCount> countKeeper) {
    for (int i = 0; i < countKeeper.size(); i++) {
        cout << "#" << right << setw(2) << i + 1 << " " << left << setw(8) << countKeeper.at(i).word << ":" << right
             << setw(3) << countKeeper.at(i).count << endl;
    }
}

//function to get the most frequent word
void mostFrequentWord(vector<WordCount> countKeeper){
    //variable for having the most frequency
    string mostFreqWord;
    //variable that will temporarily store that said frequency (baseline = 1);
    int wordFreq = 1;

    //for loop to iterate and update most freq..
    for(int i = 0; i < countKeeper.size(); i++){
        if(countKeeper.at(i).count > wordFreq){
            mostFreqWord = countKeeper.at(i).word;
            wordFreq = countKeeper.at(i).count;
        }
    }
    cout << "Most Frequent:  " << left << setw(6) << mostFreqWord << "(" <<  wordFreq << ")" << endl;
}

//similar function to get the least frequent word
void leastFrequentWord(vector<WordCount> countKeeper){
    //variable for least frequency
    string leastFreqWord;
    //variable that holds lowest freq (1 is the lowest possible)
    int wordFreq = 10000000;

    //for loop to iterate and update least freq
    for(int i = 0; i < countKeeper.size(); i++){
        if(countKeeper.at(i).count < wordFreq){
            leastFreqWord = countKeeper.at(i).word;
            wordFreq = countKeeper.at(i).count;
        }
    }
    cout << "Least Frequent: " << left << setw(6) << leastFreqWord << "(" << wordFreq << ")" << endl;

}

//function to create and store all letters in user input in an array, very similar to the countKeeper vector.
int findLetterFrequency(string userText, WordCount userLetters[]){
    //variable for total.. denominator when finding percentages. it is double to ensure decimal values are returned
    double total;
    //character that will be iterated to run through the whole alphabet.
    char alphabet = 'A';

    //for loop to create the initial array
    for(int i = 0; i < 26; i++){
        userLetters[i].count = 0;
        userLetters[i].word = alphabet;
        //goes to next letter
        alphabet += 1;
    }

    //for loop to update the counts for all letter THERE IS 100% MOST CERTAINLY WITHOUT A DOUBT IN MY MIND THAT THIS CAN BE DONE EXPONENTIALLY BETTER
    for(char &c : userText) {
        if(c == 'A'){
            userLetters[0].count += 1;
        }
        else if(c == 'B'){
            userLetters[1].count += 1;
        }
        else if(c == 'C'){
            userLetters[2].count += 1;
        }
        else if(c == 'D'){
            userLetters[3].count += 1;
        }
        else if(c == 'E'){
            userLetters[4].count += 1;
        }
        else if(c == 'F'){
            userLetters[5].count += 1;
        }
        else if(c == 'G'){
            userLetters[6].count += 1;
        }
        else if(c == 'H'){
            userLetters[7].count += 1;
        }
        else if(c == 'I'){
            userLetters[8].count += 1;
        }
        else if(c == 'J'){
            userLetters[9].count += 1;
        }
        else if(c == 'K'){
            userLetters[10].count += 1;
        }
        else if(c == 'L'){
            userLetters[11].count += 1;
        }
        else if(c == 'M'){
            userLetters[12].count += 1;
        }
        else if(c == 'N'){
            userLetters[13].count += 1;
        }
        else if(c == 'O'){
            userLetters[14].count += 1;
        }
        else if(c == 'P'){
            userLetters[15].count += 1;
        }
        else if(c == 'Q'){
            userLetters[16].count += 1;
        }
        else if(c == 'R'){
            userLetters[17].count += 1;
        }
        else if(c == 'S'){
            userLetters[18].count += 1;
        }
        else if(c == 'T'){
            userLetters[19].count += 1;
        }
        else if(c == 'U'){
            userLetters[20].count += 1;
        }
        else if(c == 'V'){
            userLetters[21].count += 1;
        }
        else if(c == 'W'){
            userLetters[22].count += 1;
        }
        else if(c == 'X'){
            userLetters[23].count += 1;
        }
        else if(c == 'Y'){
            userLetters[24].count += 1;
        }
        else if(c == 'Z'){
            userLetters[25].count += 1;
        }

    }

    //for loop that calculates total letters
    for(int i = 0; i < 26; i++){
        total += userLetters[i].count;
    }

    //for loop that prints out letters and frequency
    for(int i = 0; i < 26; i++){
        cout << userLetters[i].word << ":" << right << setw(7) << fixed << setprecision(3) << (userLetters[i].count / total) * 100 << "%";
        cout << endl;
    }

    return total;
}

//function to get the most frequent letter
void mostFrequentLetter(WordCount userLetters[]){
    //variable for having the most frequency
    string mostFreqLet;
    //variable that will temporarily store that said frequency (baseline = 1);
    int letterFreq = 1;

    //for loop to iterate and update most freq..
    for(int i = 0; i < 26; i++){
        if(userLetters[i].count > letterFreq && userLetters[i].count > 0){
            mostFreqLet = userLetters[i].word;
            letterFreq = userLetters[i].count;
        }
    }
    cout << "Most Frequent:  " << setw(1) << mostFreqLet << "  (" <<  letterFreq << ")" << endl;
}

//similar function to get the least frequent word
void leastFrequentLetter(WordCount userLetters[]) {
    //variable for least frequency
    string leastFreqLet;
    //variable that holds lowest freq (1 is the lowest possible)
    int letterFreq = 10000000;

    //for loop to iterate and update least freq
    for (int i = 0; i < 26; i++) {
        if (userLetters[i].count < letterFreq) {
            leastFreqLet = userLetters[i].word;
            letterFreq = userLetters[i].count;
        }
    }
    cout << "Least Frequent: " << setw(1) << leastFreqLet << "  (" <<  letterFreq << ")" << endl;
}


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
