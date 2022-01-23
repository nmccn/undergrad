//
// Created by Nicholas McClellan on 2019-12-01.
//

#include "animal_functions.h"

/**
 * Sets up the recursive call to the read_preorder
 * @return root of the tree
 */
node* read_game_tree() {
    //use constructor to create empty node
    node* root = new node;

    //open the file
    ifstream game_data;
    game_data.open("animal_game_tree.txt");

    //give data and node to the preorder function (recursive function)
    if(game_data.is_open()){
        read_preorder(root, game_data);
    }

    //close the file
    game_data.close();

    return root;
}

/**
 * Plays the game
 * @param root Root of the game tree
 */
void play_game(node* root) {
    //node to traverse tree (starting at the root)
    node *ptr = root;
    //strings for the user input to 2 questions output by program, init to a.
    char user_answer = 'a';
    char extend_answer = 'a';
    //bool for which direction to go (based on y/n), Y goes left.
    bool answered_yes;
    //bool to control the outer loop
    bool keepGoing = true;

    //user responses
    queue<char> user_inputs;

    //while not at the end of the tree (leaf)
    while (keepGoing) {
        //prompt the user with the question
        cout << ptr->data << endl;
        //get their input
        cin >> user_answer;
        //check for valid input
        while (!(user_answer == 'y' || user_answer == 'n')) {
            cout << "Enter a valid response (y/n) " << endl;
            cin >> user_answer;
        }
        //add the response to the queue, then interpret input and progress through the tree
        user_inputs.push(user_answer);
        if (user_answer == 'y') {
            answered_yes = true;
        } else {
            answered_yes = false;
        }
        //Base cases
        //leaf and answer_yes
        if (ptr->isLeaf && answered_yes) {
            cout << "YAY! I guessed your animal!" << endl;
            keepGoing = false;
        }
            //leaf and NOT answer_yes
        else if (ptr->isLeaf && !answered_yes) {
            cout << "BOO! I don't know!" << endl << endl;
            //ask for (& potentially extend the game tree)
            cout << "Would you like to expand the game tree (y/n)? ";
            cin >> extend_answer;
            while (!(extend_answer == 'y' || extend_answer == 'n')) {
                cout << "Enter a valid response (y/n) " << endl;
                cin >> extend_answer;
            }
            if (extend_answer == 'y') {
                output_game_history(root, user_inputs);
                extend_game_tree(ptr);
                cout << endl;
            }
            keepGoing = false;
        }
            //not a leaf and answered yes
        else if (!ptr->isLeaf && answered_yes) {
            ptr = ptr->left;
        }
            //not a leaf and answered no
        else if (!ptr->isLeaf && !answered_yes) {
            ptr = ptr->right;
        }
    }
}


/**
 * Writes the game tree, sets up a recursive call to write_preorder();
 * @param root The root of the tree
 */
void write_game_tree(node* root) {
    //prompt the user for a file name
    string file_name;
    cout << "\n" << "Enter a file name (such as example.txt): ";
    cin >> file_name;

    //create an ofs stream
    ofstream save_file(file_name, fstream::app);

    if(save_file.is_open()){
        write_preorder(root, save_file);
    }
    else{
        return;
    }
    cout << "\n" << "Game file saved in '" << file_name << "'"<< endl;
    save_file.close();
    cin.ignore();
}


/**
 * Setup game tree, called recursively
 * @param the root of the tree and the file for the text to be read from
 */
void read_preorder(node* root, ifstream& fin){
    //to get each line, to then separate into words later
    string line_in_file;
    getline(fin, line_in_file);

    //break apart each sentence, and then populate the tree
    stringstream ba(line_in_file);
    string word;

    //while there are words to separate
    while (ba >> word){
        //The two cases where we get #Q or #A
        //The only instance that the line of text is a leaf is when it is an attempt at an answer (ie: Is it a dolphin?)
        if(word == "#A"){
            root->isLeaf = true;
        }
        else if(word == "#Q") {
            root->isLeaf = false;
        }
        else{
            root->data += " " + word;
        }
    }
    //Eliminate the leading whitespace
    root->data.erase(root->data.begin(), root->data.begin()+1);
    //add the Y/N?
    root->data += " (y/n): ";

    //Recurse further if not a leaf
    if(!root->isLeaf){
        root->left = new node;
        root->right = new node;
        read_preorder(root->left, fin);
        read_preorder(root->right, fin);
    }
    else{
        return;
    }
}

/**
 * Output the game tree, again called recursively.
 * @param the root of the tree and the output stream used to write to the file
 */
void write_preorder(node* root, ofstream& ofs) {
    //to get each line, to then separate into words later
    string line_in_file;
    //break apart each sentence, and then populate the tree
    ostringstream save_tree;

    //recursing through and adding the appropriate data & tags
    if (root->isLeaf) {
        size_t i = root->data.find("(y/n)");
        if(i != string::npos) {
            root->data.erase(root->data.end() - 8, root->data.end());
        }
        save_tree << "#A " << root->data << endl;
        ofs << save_tree.str();
        return;
    }
    else {
        size_t i = root->data.find("(y/n)");
        if(i != string::npos) {
            root->data.erase(root->data.end() - 8, root->data.end());
        }
        save_tree << "#Q " << root->data << endl;
        ofs << save_tree.str();
        write_preorder(root->left, ofs);
        write_preorder(root->right, ofs);
    }
}

/**
 * Output the traversal of the tree thus far, aswell as all of the corresponding answers
 * @param root of the tree, and the queue of characters (relating to the users input answers)
 */
void output_game_history(node* root, queue<char> answers){
    //output to the user the previous questions & their answers
    cout << "\n" << "I asked the following: " << endl;
    //traverse the queue to get answers
    while(!answers.empty()){
        //output question and answer
        cout << root->data << " " << answers.front() << endl;
        //move down the tree in the correct direction
        if(answers.front() == 'y'){
            root = root->left;
        }
        else{
            root = root->right;
        }
        //remove the answer already used
        answers.pop();
    }
}
/**
 *
 * @param
 */
void extend_game_tree(node* leaf){
    //strings for user inputs
    string user_input1;
    string user_input2;


    //Prompting and retrieving the new question/answer
    cout << endl;
    cout << "Enter a new animal in the form of a question (e.g. is it a platypus?): " << endl;
    cin.ignore();
    getline(cin,user_input1);
    cout << "Now enter a question for which the answer is yes for your new animal, and which does not contract your previous answers: " << endl;
    getline(cin, user_input2);


    //placing the node in the tree.
    node* expanded_node = new node;
    expanded_node->data = leaf->data;
    leaf->data = user_input2;
    leaf->isLeaf = false;

    //adding new children nodes
    leaf->left = new node;
    leaf->left->data = user_input1;
    leaf->left->isLeaf = true;
    leaf->right = new node;
    leaf->right->data = expanded_node->data;
    leaf->right->isLeaf = true;
}

/**
 * Deletes the game tree
 * @param root Root of the game tree
 */
void delete_game_tree(node* root) {
    // Optional. Do a post-order deletion of the game tree.
    // This isn't strictly needed as the program exits after this is called,
    // which frees up all the memory anyway.
}
