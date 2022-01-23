#include <cassert>
#include <cstddef>
#include <stdexcept>
#include "types/thread/thread.hpp"

void Thread::set_ready(int time) {
    previous_state = current_state;
    current_state = READY;
    state_change_time = time;
}

void Thread::set_running(int time) {
    previous_state = current_state;
    current_state = RUNNING;
    state_change_time = time;
}

void Thread::set_blocked(int time) {
    previous_state = current_state;
    current_state = BLOCKED;
    state_change_time = time;
}

void Thread::set_finished(int time) {
    previous_state = current_state;
    current_state = EXIT;
    state_change_time = time;
}

int Thread::response_time() const {
    return (start_time - arrival_time);
}

int Thread::turnaround_time() const {
    return (end_time - arrival_time);
}

void Thread::set_state(ThreadState state, int time) {
    switch (current_state)
    {
        case NEW:
            if (state == READY) {
                set_ready(time);
            }
            else {
                throw("Bad transition!\n");
            }
            break;
        case READY:
            if (state == RUNNING) {
                // to only set the start time once 
                if (start_time == -1) {
                    start_time = time;
                }
                set_running(time);
            }
            else {
                throw("Bad transition!\n");
            }
            break;
        case RUNNING:
            if (state == READY) {
                set_ready(time);
            }
            else if (state == BLOCKED) {
                set_blocked(time);
            }
            else if (state == EXIT) {
                end_time = time;
                set_finished(time);
            }
            else {
                throw("Bad transition!\n");
            }
            break;
        case BLOCKED:
            if (state == READY) {
                set_ready(time);
            }
            else {
                throw("Bad transition!\n");
            }
            break;
        case EXIT:
            std::cout << "Thread: " << this->thread_id << std::endl;
            std::cout << "This state has no valid transitions\n";
            break;
        default:
            std::cout << "CURRENT_STATE INVALID, Reached in error (?)\n";
    }
}

std::shared_ptr<Burst> Thread::get_next_burst(BurstType type) {
    if (bursts.empty()) {
        return nullptr;
    }
    else {
        if (bursts.front()->burst_type == type) {
            return bursts.front();
        }
        else {
            return nullptr;
        }
    }
}

std::shared_ptr<Burst> Thread::pop_next_burst(BurstType type) {
    if (bursts.empty()) {
        return nullptr;
    }
    else {
        std::shared_ptr<Burst> next = get_next_burst(type);
        if (next != nullptr) {
            bursts.pop();
        }
        return next;
    }
}