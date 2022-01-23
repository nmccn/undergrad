/* CSCI261 Lab: stringTest
 *
 * Author: Nicholas McClellan
 *
 * This program executes some tests that illustrate the properties
 * and behaviors of strings.
 *
 * Copyright 2019 Dr. Jeffrey Paone

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
 *
*/

#include <iomanip>
#include <iostream>
#include <string>
using namespace std;

void runAllTests();

int main() {

    cout << "Testing your functions...\n\n";
    runAllTests();

    // Exit program.
    return 0;
}


// A generic test function, that simply prints "PASSED" if b is true
// and otherwise prints false. Do not modify this function.
void test(const string MESSAGE, const string LHS, const string RHS)  {
    cout << setw(30);
    cout << MESSAGE << ": ";
    cout << setw(15);
    if (LHS == RHS)
        cout << " PASSED   \n";
    else
        cout << " !!>FAILED<!! \"" << LHS << "\" != \"" << RHS << "\"\n";
}

// A generic test function, that simply prints "PASSED" if b is true
// and otherwise prints false. Do not modify this function.
void test(const string MESSAGE, const int LHS, const int RHS)  {
    cout << setw(30);
    cout << MESSAGE << ": ";
    cout << setw(15);
    if (LHS == RHS)
        cout << " PASSED   \n";
    else
        cout << " !!>FAILED<!! " << LHS << " != " << RHS << "\n";
}

// Returns the length of a string
int stringLength(const string STR)  {
    return STR.length();
}

// Returns the character of a string at a given index
char charAt(const string STR, const int IDX) {
    return STR.at(IDX); // stub
}

// Returns a concatenation of strings left and right
string stringAppend(const string LEFT, const string RIGHT)  {
    string COMBINED;
    COMBINED = LEFT + RIGHT;
    return COMBINED; // stub
}

// Returns the result of inserting a string into another
string stringInsert(const string STR, const string& TO_INSERT, const int IDX) {
    string str = STR;
    str.insert(IDX, TO_INSERT);
    return str; // stub
}

// Returns the first index of character c in string s
int stringFind(const string STR, const char C)  {
    int firstIndex;
    firstIndex = STR.find(C);
    return firstIndex; // stub
}

// Returns part of a string
string stringSubstring(const string STR, const int IDX, const int LEN) {
    string REMAINDER;
    REMAINDER = STR.substr(IDX, LEN);
    return REMAINDER; // stub
}

// Replaces part of a string
string stringReplace(const string STR, const string TEXT_TO_REPLACE, const string REPLACE_WITH) {
    string str = STR;
    /*At first I couldn't figure out correct syntax for using replace function from <string>...
    string str = STR;
    int IDX = str.find(TEXT_TO_REPLACE);
    str.erase(IDX, TEXT_TO_REPLACE.length());
    str.insert(IDX, REPLACE_WITH);
     */
    str.replace(str.find(TEXT_TO_REPLACE), TEXT_TO_REPLACE.length(), REPLACE_WITH);
    return str; // stub
}

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

// Returns the second word, given a sentence
string secondWord(const string STR)  {
    string str = STR;
    str = removeFirstWord(str);
    str = firstWord(str);
    return str; // stub
}

// Returns the third word, given a sentence
string thirdWord(const string STR)  {
    string str = STR;
    str = removeFirstWord(str);
    str = removeFirstWord(str);
    str = firstWord(str);
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

// Returns a string substituting character target with character replacement
string substitute(const string STR, const char TARGET, const char REPLACEMENT)  {
    string str = STR;
   for(int i = 0; i < str.length(); i++){
       if(charAt(str, i) == TARGET){
           str.at(i) = REPLACEMENT;
       }
   }
    return str; // stub
}

// Test suite. You should read, but not modify, this function.
void runAllTests()  {
    test( "Testing length()", 			stringLength("Now") , 3 );
    test( "Testing length()", 			stringLength("Tablet") , 6 );
    test( "Testing at()", 				charAt("Elephant", 3) , 'p' );
    test( "Testing at()", 				charAt("Giraffe", 2) , 'r' );
    test( "Testing append()", 			stringAppend("There's a ", "natural mystic.") , "There's a natural mystic." );
    test( "Testing append()", 			stringAppend("It's the ", "eye of the tiger.") , "It's the eye of the tiger." );
    test( "Testing insert()", 			stringInsert("If you carefully.", "listen ", 7) , "If you listen carefully." );
    test( "Testing insert()", 			stringInsert("carefully.", "Watch ", 0) , "Watch carefully." );
    test( "Testing find()", 			stringFind("Have to face reality now.", 'o') , 6 );
    test( "Testing find()", 			stringFind("Have to face reality now.", 'e') , 3 );
    test( "Testing substr()", 			stringSubstring("Such a natural mystic", 7, 7) , "natural" );
    test( "Testing substr()", 			stringSubstring("Such a natural mystic", 0, 4) , "Such" );
    test( "Testing replace()", 			stringReplace("Strings are not the way", "Strings", "Things") , "Things are not the way" );
    test( "Testing replace()", 			stringReplace("Show me the things", "things", "way") , "Show me the way" );
    test( "Testing firstWord()", 		firstWord("The quick brown fox jumped over the lazy dog") , "The" );
    test( "Testing firstWord()", 		firstWord("A man a plan a canal Panama") , "A" );
    test( "Testing firstWord()", 		firstWord("I have the hang of this") , "I" );
    test( "Testing removeFirstWord()",  removeFirstWord("The quick brown fox jumped over the lazy dog") , "quick brown fox jumped over the lazy dog" );
    test( "Testing removeFirstWord()",  removeFirstWord("Goodbye") , "" );
    test( "Testing removeFirstWord()",  removeFirstWord(removeFirstWord("The quick brown fox jumped over the lazy dog")) , "brown fox jumped over the lazy dog" );
    test( "Testing secondWord()", 		secondWord("The quick brown fox jumped over the lazy dog") , "quick" );
    test( "Testing secondWord()", 		secondWord("A man a plan a canal Panama") , "man" );
    test( "Testing secondWord()", 		secondWord("I have the hang of this") , "have" );
    test( "Testing thirdWord()", 		thirdWord("The quick brown fox jumped over the lazy dog") , "brown" );
    test( "Testing thirdWord()", 		thirdWord("A man a plan a canal Panaman") , "a" );
    test( "Testing thirdWord()", 		thirdWord("I have the hang of this") , "the" );
    test( "Testing nthWord(1)", 		nthWord("The quick brown fox jumped over the lazy dog", 1) , "The" );
    test( "Testing nthWord(2)", 		nthWord("The quick brown fox jumped over the lazy dog", 2) , "quick" );
    test( "Testing nthWord(3)", 		nthWord("The quick brown fox jumped over the lazy dog", 3) , "brown" );
    test( "Testing nthWord(4)", 		nthWord("The quick brown fox jumped over the lazy dog", 4) , "fox" );
    test( "Testing nthWord(5)", 		nthWord("The quick brown fox jumped over the lazy dog", 5) , "jumped" );
    test( "Testing nthWord(6)", 		nthWord("The quick brown fox jumped over the lazy dog", 6) , "over" );
    test( "Testing nthWord(7)", 		nthWord("The quick brown fox jumped over the lazy dog", 7) , "the" );
    test( "Testing nthWord(8)", 		nthWord("The quick brown fox jumped over the lazy dog", 8) , "lazy" );
    test( "Testing nthWord(9)", 		nthWord("The quick brown fox jumped over the lazy dog", 9) , "dog" );
    test( "Testing substitute()", 		substitute("The Gxxgle", 'x', 'o') , "The Google" );
    test( "Testing substitute()", 		substitute("$chool of Mine$", '$', 's') , "school of Mines" );
    test( "Testing substitute()", 		substitute(substitute("D--", '-', '+'), 'D', 'C') , "C++" );
}
