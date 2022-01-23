//
// Created by Nicholas McClellan on 2019-11-25.
//

#ifndef LAB12_ANALOG_CLOCK_H
#define LAB12_ANALOG_CLOCK_H

#include "unix_clock.h"

class analog_clock : public unix_clock {
public:
    //Constructor provided in the lab instructions
    analog_clock(unix_clock c) : unix_clock(c) {};
    //all functions are fine with the exception of get_time, the padding must be eliminated and am/pm accounted for
    string get_time(){
        string time;

        //hour check and add to time
        if(get_hour() == 0){
            time += "00:";
        }
        else {
            time += to_string(get_hour()) + ":";
        }

        //minute check and add
        if(get_minute() > 10){
            time += to_string(get_minute()) + ":";
        }
        else{
            time += "0" + to_string(get_minute()) + ":";
        }

        //second check and add
        if(get_second() > 10){
            time += to_string(get_second()) + ":";
        }
        else{
            time += "0" + to_string(get_second()) + ":";
        }

        //am versus pm check
        if(get_hour() <= 12){
            time += "am";
        }
        else{
            time += "pm";
        }

        return time;
    }


};
#endif //LAB12_ANALOG_CLOCK_H
