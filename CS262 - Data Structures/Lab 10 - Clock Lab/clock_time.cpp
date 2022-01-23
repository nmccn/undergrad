//
// Created by Nicholas McClellan on 2019-11-01.
//

#include "clock_time.h"


int clock_time::get_hour(){
    //overflow
    if(_seconds / 3600 > 24){
        return (_seconds / 3600) % 24;
    }
    //underflow, not sure why the -1 is necessary.
    if(_seconds / 3600 < 0){
        return (((_seconds / 3600) % 24) + 24)-1;
    }
    //normal behavior
    else {
        return _seconds / 3600;
    }
};

int clock_time::get_minute(){
    //underflow
    if(_seconds % 3600 < 0){
        return ((_seconds % 3600)+3600)/60;
    }
    //normal
    else {
        return (_seconds % 3600) / 60;
    }
};
int clock_time::get_second(){
    //underflow
    if(_seconds % 60 < 0){
        return (_seconds % 60)+60;
    }
    //normal behavior
    else {
        return _seconds % 60;
    }
};

void clock_time::set_time(int h, int m, int s){
    _seconds += h * 3600;
    _seconds += m * 60;
    _seconds += s;
};

clock_time::clock_time(){
    set_time(0, 0, 0);
};

clock_time::clock_time(int h, int m, int s){
    set_time(h, m, s);
}

clock_time operator+(clock_time a, clock_time b) {
    clock_time c;
    c._seconds = a._seconds + b._seconds;
    return c;
}

bool operator!=(clock_time a, clock_time b) {
    //check if total seconds is different
    if(a == b){
        return false;
    }
    else{
        return true;
    }
}

bool operator==(clock_time a, clock_time b) {
    //check if the total seconds is the same
    if(a.get_hour() == b.get_hour()){
        if(a.get_minute() == b.get_minute()){
            if(a.get_second() == b.get_second()){
                return true;
            }
        }
    }
    else{
        return false;
    }
}

//Part 2 Functions
//Output the human-readable time to the output stream out.
ostream & operator<<(ostream & out, clock_time c){
    out << to_string(c);
    return out;
}

//	Return the human-readable time as a string.
string to_string(clock_time c){
    //string to actually return
    string output = "";
    //string stream to convert from int to string and add to output
    stringstream getOutput;
    //hour
    getOutput << c.get_hour();
    getOutput << ":";
    //minutes with padding
    if(c.get_minute() < 10){
        getOutput << "0";
        getOutput << c.get_minute();
    }
    else{
        getOutput << c.get_minute();
    }
    getOutput << ":";
    //seconds with padding
    if(c.get_second() < 10){
        getOutput << "0";
        getOutput << c.get_second();
    }
    else{
        getOutput << c.get_second();
    }
    output = getOutput.str();

    return output;
}

