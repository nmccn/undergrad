#include "algorithms/rr/rr_algorithm.hpp"

#include <cassert>
#include <stdexcept>
#include <sstream>

/*
    Here is where you should define the logic for the round robin algorithm.
*/

RRScheduler::RRScheduler(int slice) {
    if (!slice) {
        time_slice = 3;
    }   
    if (slice < 3) {
        time_slice = 3;
        throw("RR has a default time-slice of '3'");
    }
    else {
        time_slice = slice;
    }
}

std::shared_ptr<SchedulingDecision> RRScheduler::get_next_thread() {
    if (empty()) {
        return nullptr;
    }
    else {
        std::shared_ptr<SchedulingDecision> next_thread = std::make_shared<SchedulingDecision> ();
        next_thread->thread = ready_queue.front();
        next_thread->time_slice = this->time_slice;
        next_thread->explanation = "RR: Selected from " + std::to_string(this->size()) + " threads. Running until completed OR preempted. time_slice = " + std::to_string(time_slice) +"\n";
        // Remove the element (?)
        //ready_queue.pop();
        // Is this correct (?)
        return next_thread;
    }
}

void RRScheduler::add_to_ready_queue(std::shared_ptr<Thread> thread) {
    ready_queue.push(thread);
}

size_t RRScheduler::size() const {
    return ready_queue.size();
}
