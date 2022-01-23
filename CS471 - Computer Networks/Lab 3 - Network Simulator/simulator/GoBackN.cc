#include "includes.h"
#define N 10
#define a 0.125
#define b 0.25

// ***************************************************************************
// * ALTERNATING BIT AND GO-BACK-N NETWORK EMULATOR: VERSION 1.1  J.F.Kurose
// *
// * These are the functions you need to fill in.
// ***************************************************************************

// ***************************************************************************
// * Because of the way the simulator works you will likey need global variables
// * You can define those here.
// ***************************************************************************
// Two structs for either side (send/receive)
struct snd {
    int base;
    int nextseqnum;
    float time_interval;
    int idx;
    struct pkt send_packets[10];
} A_side;

struct rcv {
    int expectedseqnum;
    struct pkt ack_packet;
} B_side;

// For the Timeout Interval
float EstRTT = 1.0;
float SampleRTT = 1.0;
float DevRTT = 1.0;
float start_time;
float stop_time;


// ***************************************************************************
// * The following routine will be used to both a make packet and calculate
// * and populate the checksum field. 
// ***************************************************************************
struct pkt *make_pkt(int seq, int ack, struct msg *message) {
    struct pkt* packet = (struct pkt*) malloc(sizeof(struct pkt));
    memcpy(packet->payload, message->data, sizeof(message->data));
    packet->seqnum = seq;
    packet->acknum = ack;
    packet->checksum = create_checksum(packet->seqnum, packet->acknum, message);
    return packet;
}

// ***************************************************************************
// * The following is a simple helper functions to calculate the checksum of 
// * a particular packets subset of data and to check for corruption.
// ***************************************************************************
int create_checksum(struct pkt *packet) {
    int cs = packet->seqnum + packet->acknum;
    struct msg *msg = (struct msg *)malloc(sizeof(struct msg));
    memcpy(msg->data, packet->payload, sizeof(struct msg));
    for(char c: msg->data) {
        cs += c;
    }
    return cs;
}

bool isCorrupt(struct pkt packet) {
    // Extract the data
    struct msg *message = (struct msg*) malloc(sizeof(struct msg));
    memcpy(message->data, packet.payload, sizeof(packet.payload));
    if (packet.checksum == create_checksum(packet.seqnum, packet.acknum, message)) {
        return true;
    }
    else {
        return false;
    }
}

void tx_packets() {
    // To transmit/retransmit packets in the window
    while ((A_side.nextseqnum < A_side.idx) && A_side.nextseqnum < A_side.base + N) {
        struct pkt *packet = &A_side.send_packets[A_side.nextseqnum % N];
        simulation->tolayer3(A, *packet);
        if (A_side.base == A_side.nextseqnum) {
            simulation->starttimer(A, A_side.time_interval);
        }
        A_side.nextseqnum++;
    }
}
// ***************************************************************************
// * The following routine will be called once (only) before any other
// * entity A routines are called. You can use it to do any initialization
// ***************************************************************************
void A_init() {
    // Initialize all of the variables as shown in fig. 3.20
    A_side.base = 1;
    A_side.nextseqnum = 1;
    A_side.time_interval = 5;
    A_side.idx = 1;
}

// ***************************************************************************
// * The following rouytine will be called once (only) before any other
// * entity B routines are called. You can use it to do any initialization
// ***************************************************************************
void B_init() {
    // Create generic Response for the ACK packets
    B_side.expectedseqnum = 1;
    B_side.ack_packet.seqnum = 0;
    B_side.ack_packet.acknum = 0;
    memset(B_side.ack_packet.payload, 0, 20);
    B_side.ack_packet.checksum = calc_checksum(&B_side.ack_packet);
}

// ***************************************************************************
// * Called from layer 5, passed the data to be sent to other side 
// ***************************************************************************
int A_output(struct msg message) {
    std::cout << "Layer 4 on side A has recieved a message from the application that should be sent to side B: " << message << std::endl;
    // If the next sequest number is in our 'window'
    if (A_side.nextseqnum < A_side.base + N) {
        // Create packet to store in the array of packets to send.
        sndpkt[A_side.nextseqnum % N] = make_pkt(A_side.nextseqnum, 0, &message);
        // udt_send()
        tx_packets();
        return 1; 
    }
    else {
        return 0; /* Return a 0 to refuse the message */
    }
}

// ***************************************************************************
// * Called from layer 3, when a packet arrives for layer 4 on side A
// ***************************************************************************
void A_input(struct pkt packet) {
    std::cout << "Layer 4 on side A has recieved a packet sent over the network from side B:" << packet << std::endl;
    // If not corrupt
    if (!isCorrupt(packet)) {
        A_side.base = packet.acknum + 1;
        if (A_side.base == A_side.nextseqnum) {
            // Calculations for the new timeInterval are here (????)
            //stop_time = simulation->getSimulatorClock();
            // SampleRTT = start_time - stop_time;        
            // EstRTT = (1-a) * EstRTT + a * SampleRTT;
            // DevRTT = (1-b) * DevRTT + b * abs(SampleRTT-EstRTT);
            // timeInterval = EstRTT + 4*DevRTT;
            simulation->stoptimer(A);
            tx_packets();
        }
        else {
            //start_time = simulation->getSimulatorClock();
            simulation->starttimer(A, A_side.time_interval);
        }
    }
    // If corrupt
    else {
        printf("ACK Packet was corrupted\n");
    }
} 

// ***************************************************************************
// * Called from layer 5, passed the data to be sent to other side
// ***************************************************************************
int B_output(struct msg message) {
    std::cout << "Layer 4 on side B has recieved a message from the application that should be sent to side A: " << message << std::endl;
    return (1); /* Return a 0 to refuse the message */
}

// ***************************************************************************
// // called from layer 3, when a packet arrives for layer 4 on side B 
// ***************************************************************************
void B_input(struct pkt packet) {
    std::cout << "Layer 4 on side B has recieved a packet from layer 3 sent over the network from side A:" << packet << std::endl;
    // Extract the data (ie. payload)
    struct msg *message = (struct msg*) malloc(sizeof(struct msg));
    memcpy(message->data, packet.payload, sizeof(packet.payload));
    // Check if the packet is not corrupt & has the correct sequence number
    if ((packet.seqnum == expectedseqnum) && (!isCorrupt(packet))) {
        // deliver_data()
        simulation->tolayer5(B, *message);
        // update rcv_sndpkt
        rcv_sndpkt = make_pkt(expectedseqnum, expectedseqnum, message);
        // udt_send()
        simulation->tolayer3(B, *rcv_sndpkt);
        expectedseqnum++;
    }
    // Otherwise (Default), it needs to resend last ACK(?)
    else {
        // udt_send()
        simulation->tolayer3(B, *rcv_sndpkt);
    }
}

// ***************************************************************************
// * Called when A's timer goes off 
// ***************************************************************************
void A_timerinterrupt() {
    std::cout << "Side A's timer has gone off." << std::endl;
    // Interval is doubled upon an interrupt (from textbook?) & we record a new start_time
    // timeInterval = timeInterval * 2;
    // start_time = simulation->getSimulatorClock();
    // Start the timer
    simulation->starttimer(A, timeInterval);
    // Loop through and resend base->nextseqnum-1
    for (int i = base; i < nextseqnum; i++) {
        simulation->tolayer3(A, *sndpkt[i % N]);
    }
}

// ***************************************************************************
// * Called when B's timer goes off 
// ***************************************************************************
void B_timerinterrupt() {
    std::cout << "Side B's timer has gone off." << std::endl;
}
