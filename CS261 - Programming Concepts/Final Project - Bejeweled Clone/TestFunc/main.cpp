#include <iostream>
#include <cmath>
#include <stdlib.h>     /* srand, rand */
#include <time.h>       /* time */
#include <iomanip>


using namespace std;

const int NUM_ROWS = 4;
const int NUM_COLS = 4;
int userMatrix[NUM_ROWS][NUM_COLS];

class Tile {
    int tColor;
    int tSize;
    int tSides;
};

//FUNCTION TO CREATE THE INITIAL MATRIX
int createBoard(const int NUM_ROWS, const int NUM_COLS) {
    //For loop to get original matrix
    for (int i = 0; i < NUM_ROWS; i++) {
        for (int j = 0; j < NUM_COLS;+ 1 j++) {
            int tempVal = rand() % 3 ;
            userMatrix[i][j] = tempVal;
        }
    }
    cout << "\n";

    //For loop to output original matrix Note: May be better way to do the [] of the matrix.
    cout << "The matrix you entered is: " << endl;
    for (int i = 0; i < NUM_ROWS; i++) {
        cout << "[";
        for (int j = 0; j < NUM_COLS; j++) {
            cout << setw(6) << userMatrix[i][j];
            cout << " ";
        }
        cout << "]";
        cout << "\n";
    }
    cout << "\n";
    return userMatrix[NUM_ROWS][NUM_COLS];
}

//PRINT THE CURRENT STATE OF THE BOARD
void printBoard(int myArray[NUM_ROWS][NUM_COLS]){
    for(int i = 0; i < NUM_ROWS; i++){
        cout << endl;
        for(int j = 0; j < NUM_COLS; j++){
            cout << myArray[i][j];
            cout << " ";
        }
    }
}

void getPosition(){
    CircleShape circ;
    RectangleShape rect;
    CircleShape triangle(80, 3);
    for (int i = 0; i < NUM_ROWS; i++){
        for (int j = 0; j < NUM_COLS; j++){
            int xPos = (i + 1) * 50;
            int yPos = (j + 1) * 50;
            if(myArray[i][j] == 0){
               circ.setPosition(xPos, yPos);
               window.draw(circ);
            }
            else if(myArray[i][j] == 1){
                rect.setPosition(xPos, yPos);
                window.draw(rect);
            }
            else {
                triangle.setPosition(xPos, yPos);
                window.draw(triangle)
            }
        }
    }
}

int checkSpaces(int userMatrix){

}



















int main() {
    Tile t1, t2, t3;
    srand(time(0));
    int myArray[NUM_ROWS][NUM_COLS];
    createBoard(NUM_ROWS,NUM_COLS);
    cout << userMatrix[0][0];
    cout << userMatrix[3][3];



}



