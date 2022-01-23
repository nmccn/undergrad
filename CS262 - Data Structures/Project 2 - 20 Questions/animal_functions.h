//
// Created by Nicholas McClellan on 2019-12-01.
//

#ifndef INC_20_QS_ANIMAL_FUNCTIONS_H
#define INC_20_QS_ANIMAL_FUNCTIONS_H

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <queue>
#include <cctype>
#include <sstream>
using namespace std;

class node {
public:
    //constructor (empty node)
    node(){
        this->left = nullptr;
        this->right = nullptr;
        this->isLeaf = false;
    };
    string data;
    node* left;
    node* right;
    bool isLeaf;
};

//baseline functions given in template
void play_game(node*);
//used to setup the recursion()
node* read_game_tree();
void write_game_tree(node*);
void delete_game_tree(node*);
////added functions
//fucntion that parses data recursively to read the file
void read_preorder(node*, ifstream&);
//function that parses data recursively to write the file
void write_preorder(node*, ofstream&);
//Function that iterates thru the queue and tree to display the questions/answers before expanding
void output_game_history(node*, queue<char>);
//expands the tree by rearranging pointers and questions/answers along with adding the new node.
void extend_game_tree(node*);

#endif //INC_20_QS_ANIMAL_FUNCTIONS_H
