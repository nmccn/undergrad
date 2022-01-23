#include <iostream>
#include <vector>


//Author: Nicholas McClellan
//Lab #6
//This is a program that will output all prime numbers until the given stop point.

int main() {
    //vector of booleans to represent the numbers up to the given maximum, initialized to true
    std::vector<bool> numbers;

    //user defined maximum number
    int maxNumber;

    //prompting the user for the max number
    std::cout << "Input a maximum number: ";
    std::cin  >> maxNumber;

    //initialize the vector to be all true
    for(int i = 0; i <= maxNumber; i++){
        numbers.push_back(true);
    }

    //actually determining the prime numbers
    for(int j = 2; j <= maxNumber; j++) {
        if (numbers.at(j)) {
            //integer for the multiplying (starting at 2 to omit 0, and whatever the j value is)
            int k = 2;
            //while loop to eliminate the multiples in range
            while (j * k <= maxNumber) {
                numbers.at(j * k) = false;
                k++;
            }
        }
        //else the number is already "crossed off"
        else {
            continue;
        }
    }

    //displaying the numbers
    for(int g = 2; g <= maxNumber; g++){
        //the check + display
        if(numbers.at(g)){
            std::cout << g << " ";
        }
    }
}