#include "algorithms/fcfs/fcfs_algorithm.hpp"

#include <cassert>
#include <stdexcept>

#define FMT_HEADER_ONLY
#include "utilities/fmt/format.h"

/*
    Here is where you should define the logic for the FCFS algorithm.
*/

FCFSScheduler::FCFSScheduler(int slice) {
    if (slice != -1) {
        throw("FCFS must have a timeslice of -1");
    }
}

std::shared_ptr<SchedulingDecision> FCFSScheduler::get_next_thread() {
    if (ready_queue.empty()) {
        return nullptr;
    }
    else {
        std::shared_ptr<SchedulingDecision> next_thread = std::make_shared<SchedulingDecision> ();
        next_thread->thread = this->ready_queue.front();
        next_thread->time_slice = -1;
        next_thread->explanation = "FCFS: Selected from " + std::to_string(this->size()) + " threads. Running until completion of burst.\n";
        // Remove the element (?)
        //ready_queue.pop();
        // Is this correct (?)
        return next_thread;
    }
}

void FCFSScheduler::add_to_ready_queue(std::shared_ptr<Thread> thread) {
    ready_queue.push(thread);
}

size_t FCFSScheduler::size() const {
    return ready_queue.size();
}
