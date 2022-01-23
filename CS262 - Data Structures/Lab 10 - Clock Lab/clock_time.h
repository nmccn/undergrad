//
// Created by Nicholas McClellan on 2019-11-01.
//

#ifndef LAB10_CLOCK_TIME_H
#define LAB10_CLOCK_TIME_H

#include <string>
#include <iostream>
#include <iomanip>
#include <sstream>
#include <iostream>


using namespace std;

class clock_time {
    friend bool operator==(clock_time a, clock_time b);
    friend bool operator!=(clock_time a, clock_time b);
    friend clock_time operator+(clock_time a, clock_time b);
public:
    int get_hour();
    int get_minute();
    int get_second();
    void set_time(int h, int m, int s);
    clock_time();
    clock_time(int h, int m, int s);
private:
    int _seconds = 0;
};

ostream & operator<<(ostream & out, clock_time c);
string to_string(clock_time c);


#endif //LAB10_CLOCK_TIME_H
