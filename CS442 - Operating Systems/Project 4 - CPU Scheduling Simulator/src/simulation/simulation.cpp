#include <fstream>
#include <iostream>

#include "algorithms/fcfs/fcfs_algorithm.hpp"
#include "algorithms/rr/rr_algorithm.hpp"

#include "simulation/simulation.hpp"
#include "types/enums.hpp"

#include "utilities/flags/flags.hpp"

unsigned int global_event_num = 0;

Simulation::Simulation(FlagOptions flags)
{
    // Hello!
    if (flags.scheduler == "FCFS")
    {
        // Create a FCFS scheduling algorithm
        this->scheduler = std::make_shared<FCFSScheduler>();
    }
    else if (flags.scheduler == "RR")
    {
        // Create a RR scheduling algorithm
        this->scheduler = std::make_shared<RRScheduler>(flags.time_slice);
    }
    this->flags = flags;
    this->logger = Logger(flags.verbose, flags.per_thread, flags.metrics);
}

void Simulation::run()
{
    this->read_file(this->flags.filename);

    while (!this->events.empty())
    {
        auto event = this->events.top();
        this->events.pop();

        // Invoke the appropriate method in the simulation for the given event type.

        switch (event->type)
        {
        case THREAD_ARRIVED:
            this->handle_thread_arrived(event);
            break;

        case THREAD_DISPATCH_COMPLETED:
        case PROCESS_DISPATCH_COMPLETED:
            this->handle_dispatch_completed(event);
            break;

        case CPU_BURST_COMPLETED:
            this->handle_cpu_burst_completed(event);
            break;

        case IO_BURST_COMPLETED:
            this->handle_io_burst_completed(event);
            break;
        case THREAD_COMPLETED:
            this->handle_thread_completed(event);
            break;

        case THREAD_PREEMPTED:
            this->handle_thread_preempted(event);
            break;

        case DISPATCHER_INVOKED:
            this->handle_dispatcher_invoked(event);
            break;
        }

        // If this event triggered a state change, print it out.
        if (event->thread && event->thread->current_state != event->thread->previous_state)
        {
            this->logger.print_state_transition(event, event->thread->previous_state, event->thread->current_state);
        }
        this->system_stats.total_time = event->time;
        event.reset();
    }
    // We are done!

    std::cout << "SIMULATION COMPLETED!\n\n";

    for (auto entry : this->processes)
    {
        this->logger.print_per_thread_metrics(entry.second);
    }

    logger.print_simulation_metrics(this->calculate_statistics());
}

//==============================================================================
// Event-handling methods
//==============================================================================

void Simulation::handle_thread_arrived(const std::shared_ptr<Event> event)
{
    // Set thread to Ready
    event->thread->set_state(READY, event->time);
    // Add thread to Ready Queue
    scheduler->add_to_ready_queue(event->thread);
    // Add thread to my vector of master threads... to loop over in calculations
    scheduler->all_threads.push_back(event->thread);
    if (active_thread == nullptr) {
        // Invoke the dispatcher, with the thread that arrived
        std::shared_ptr<Event> new_event = std::make_shared<Event>(DISPATCHER_INVOKED, event->time, global_event_num, event->thread, event->scheduling_decision);
        add_event(new_event);
        global_event_num++;
    }
    // Handling done
    return;
}

void Simulation::handle_dispatch_completed(const std::shared_ptr<Event> event)
{
    scheduler->ready_queue.pop();
    event->thread->set_state(RUNNING, event->time);
    if (scheduler->time_slice != -1) { 
        std::shared_ptr<Burst> cpu_burst = event->thread->get_next_burst(CPU);
        if (cpu_burst->length > scheduler->time_slice) {
            // deduct the time_slice from burst length.
            cpu_burst->update_time(scheduler->time_slice);
            std::shared_ptr<Event> new_event = std::make_shared<Event>(THREAD_PREEMPTED, event->time + scheduler->time_slice, global_event_num, event->thread, event->scheduling_decision);
            add_event(new_event);
            global_event_num++;
            return;
        }
    }
    else {
        std::shared_ptr<Burst> cpu_burst = event->thread->pop_next_burst(CPU);
        // Update metrics based on this CPU burst
        event->thread->service_time += cpu_burst->length;
        system_stats.service_time += cpu_burst->length;
        if (event->thread->get_next_burst(IO) == nullptr) {
            std::shared_ptr<Event> new_event = std::make_shared<Event>(THREAD_COMPLETED, event->time + cpu_burst->length, global_event_num, event->thread, event->scheduling_decision);
            add_event(new_event);
            global_event_num++;
            return;
        }
        else {
            std::shared_ptr<Event> new_event = std::make_shared<Event>(CPU_BURST_COMPLETED, event->time + cpu_burst->length, global_event_num, event->thread, event->scheduling_decision);
            add_event(new_event);
            global_event_num++;
            return;
        }
    }
}

void Simulation::handle_cpu_burst_completed(const std::shared_ptr<Event> event)
{
    // Set Thread to BLOCKED
    event->thread->set_state(BLOCKED, event->time);
    // Get Next IO Burst
    std::shared_ptr<Burst> io_burst = event->thread->pop_next_burst(IO);
    // Update metrics based on this I/O burst
    event->thread->io_time += io_burst->length;
    system_stats.io_time += io_burst->length;
    // Create new IO_BURST_COMPLETED event
    std::shared_ptr<Event> new_event = std::make_shared<Event>(IO_BURST_COMPLETED, event->time + io_burst->length, global_event_num, event->thread, event->scheduling_decision);
    add_event(new_event);
    global_event_num++;
    if(scheduler->size() != 0){
        std::shared_ptr<SchedulingDecision> next_thread = scheduler->get_next_thread();
        std::shared_ptr<Event> new_event = std::make_shared<Event>(DISPATCHER_INVOKED, event->time , global_event_num, next_thread->thread, next_thread);
        // Add new event to the Event Queue
        add_event(new_event);
        global_event_num++;
    } 
    // Handling done
    return;
}

void Simulation::handle_io_burst_completed(const std::shared_ptr<Event> event)
{
    // Set thread to READY
    event->thread->set_state(READY, event->time);
    // Add thread to Ready Queue
    scheduler->add_to_ready_queue(event->thread);
    // Is CPU idle?
    if (active_thread == nullptr || scheduler->size() == 1) {
        // Create new DISPATCHER_INVOKED event
        std::shared_ptr<Event> new_event = std::make_shared<Event>(DISPATCHER_INVOKED, event->time, global_event_num, event->thread, event->scheduling_decision);
        // Add event to the Event Queue
        add_event(new_event);
        global_event_num++;
    }
    // Handling Done
    return;
}

void Simulation::handle_thread_completed(const std::shared_ptr<Event> event)
{
    // Set thread to EXIT
    event->thread->set_state(EXIT, event->time);
    // Is CPU idle?
    std::shared_ptr<SchedulingDecision> next_thread = scheduler->get_next_thread();
    if (active_thread == nullptr && scheduler->size() != 0) {
        std::shared_ptr<Event> new_event = std::make_shared<Event>(DISPATCHER_INVOKED, event->time, global_event_num, next_thread->thread, next_thread);
        add_event(new_event);
        global_event_num++;
    }
    else if (active_thread != nullptr && scheduler->size() == 0){
        // debugging purposes, probably not useful in practice
    }
    else {
        std::shared_ptr<Event> new_event = std::make_shared<Event>(DISPATCHER_INVOKED, event->time, global_event_num, event->thread, event->scheduling_decision);
        add_event(new_event);
        global_event_num++;

    }
    // Handling Done
    return;
}

void Simulation::handle_thread_preempted(const std::shared_ptr<Event> event)
{
    unsigned int time_spent = event->time - event->thread->state_change_time;
    // Set thread to READY
    event->thread->set_state(READY, event->time);
    // Add thread to Ready Queue
    scheduler->add_to_ready_queue(event->thread);
    // Update the time-spent on CPU
    event->thread->service_time += time_spent;
    system_stats.service_time += time_spent;
    // Update Burst-Length
    event->thread->get_next_burst(CPU)->update_time(time_spent);
    auto next = scheduler->get_next_thread();
    // Make new event for DISPATCHER_INVOKED
    std::shared_ptr<Event> new_event = std::make_shared<Event>(DISPATCHER_INVOKED, event->time, global_event_num, event->thread, event->scheduling_decision);
    // Add event to the Event Queue
    add_event(new_event);
    global_event_num++;
    // Handling done
    return;
}

void Simulation::handle_dispatcher_invoked(const std::shared_ptr<Event> event)
{
    unsigned int time_spent = 0;

    if (active_thread != nullptr) {
        prev_thread = active_thread;
    }

    std::shared_ptr<SchedulingDecision> next_thread = scheduler->get_next_thread();

    if (next_thread == nullptr) {
        active_thread = nullptr;
        return;
    }
    else {
        prev_thread = active_thread;
        active_thread = next_thread->thread;
        if (prev_thread == nullptr || active_thread->process_id != prev_thread->process_id) {
            // Process Switch
            time_spent = process_switch_overhead;
            std::shared_ptr<Event> new_event = std::make_shared<Event>(PROCESS_DISPATCH_COMPLETED, event->time+time_spent, global_event_num, active_thread, next_thread);
            add_event(new_event);
        }
        else {
            // Thread switch
            time_spent = thread_switch_overhead;
            std::shared_ptr<Event> new_event = std::make_shared<Event>(THREAD_DISPATCH_COMPLETED, event->time+time_spent, global_event_num, active_thread, next_thread);
            add_event(new_event);
        }
    }
    // Update time spent on dispatch
    system_stats.total_time += time_spent;
    system_stats.dispatch_time += time_spent;
    // Add new event to Event Queue
    global_event_num++;
    return;
}    

//==============================================================================
// Utility methods
//==============================================================================

SystemStats Simulation::calculate_statistics()
{
    // CPU Util
    double util = (this->system_stats.service_time + this->system_stats.dispatch_time);
    int divisor = this->system_stats.total_time;
    util = (util / divisor) * 100;
    system_stats.cpu_utilization = util;
    // CPU Efficiency
    double effic = this->system_stats.service_time;
    effic = (effic / divisor) * 100;
    system_stats.cpu_efficiency = effic;
    // Idle Time... incorrect calculation (?) but I am not sure how to track the condition where CPU is idle during IO burst.... my code became kind of a mess
    system_stats.total_idle_time = system_stats.total_time - system_stats.service_time - system_stats.dispatch_time;
    // Calculate the Per-Thread Averages
    // Set a bunch of system_stats member variables related to the thread counts, etc 
    // There is 100% a better way to do this... 
    for (int i = 0; i < scheduler->all_threads.size(); i++) {
        if (scheduler->all_threads[i]->priority == SYSTEM) {
            system_stats.thread_counts[0] = system_stats.thread_counts[0] + 1;
            scheduler->total_response[0] += scheduler->all_threads[i]->response_time();
            scheduler->total_turnaround[0] += scheduler->all_threads[i]->turnaround_time();
        }
        else if(scheduler->all_threads[i]->priority == INTERACTIVE) {
            system_stats.thread_counts[1] = system_stats.thread_counts[1] + 1;
            scheduler->total_response[1] += scheduler->all_threads[i]->response_time();
            scheduler->total_turnaround[1] += scheduler->all_threads[i]->turnaround_time();
        }
        else if (scheduler->all_threads[i]->priority == NORMAL) {
            system_stats.thread_counts[2] = system_stats.thread_counts[2] + 1;
            scheduler->total_response[2] += scheduler->all_threads[i]->response_time();
            scheduler->total_turnaround[2] += scheduler->all_threads[i]->turnaround_time();
        }
        else if (scheduler->all_threads[i]->priority == BATCH) {
            system_stats.thread_counts[3] = system_stats.thread_counts[3] + 1;
            scheduler->total_response[3] += scheduler->all_threads[i]->response_time();
            scheduler->total_turnaround[3] += scheduler->all_threads[i]->turnaround_time();
        }
}
    for (int i = 0; i < 4; i++) {
        if (system_stats.thread_counts[i] != 0) {
            system_stats.avg_thread_response_times[i] = scheduler->total_response[i] / system_stats.thread_counts[i];
            system_stats.avg_thread_turnaround_times[i] = scheduler->total_turnaround[i] / system_stats.thread_counts[i];
        }
    }
    return this->system_stats;
}

void Simulation::add_event(std::shared_ptr<Event> event)
{
    if (event != nullptr)
    {
        this->events.push(event);
    }
}

void Simulation::read_file(const std::string filename)
{
    std::ifstream input_file(filename.c_str());

    if (!input_file)
    {
        std::cerr << "Unable to open simulation file: " << filename << std::endl;
        throw(std::logic_error("Bad file."));
    }

    int num_processes;

    input_file >> num_processes >> this->thread_switch_overhead >> this->process_switch_overhead;

    for (int proc = 0; proc < num_processes; ++proc)
    {
        auto process = read_process(input_file);

        this->processes[process->process_id] = process;
    }
}

std::shared_ptr<Process> Simulation::read_process(std::istream &input)
{
    int process_id, priority;
    int num_threads;

    input >> process_id >> priority >> num_threads;

    auto process = std::make_shared<Process>(process_id, (ProcessPriority)priority);

    // iterate over the threads
    for (int thread_id = 0; thread_id < num_threads; ++thread_id)
    {
        process->threads.emplace_back(read_thread(input, thread_id, process_id, (ProcessPriority)priority));
    }

    return process;
}

std::shared_ptr<Thread> Simulation::read_thread(std::istream &input, int thread_id, int process_id, ProcessPriority priority)
{
    // Stuff
    int arrival_time;
    int num_cpu_bursts;

    input >> arrival_time >> num_cpu_bursts;

    auto thread = std::make_shared<Thread>(arrival_time, thread_id, process_id, priority);

    for (int n = 0, burst_length; n < num_cpu_bursts * 2 - 1; ++n)
    {
        input >> burst_length;

        BurstType burst_type = (n % 2 == 0) ? BurstType::CPU : BurstType::IO;

        thread->bursts.push(std::make_shared<Burst>(burst_type, burst_length));
    }

    this->events.push(std::make_shared<Event>(EventType::THREAD_ARRIVED, thread->arrival_time, this->event_num, thread, nullptr));
    this->event_num++;

    return thread;
}
