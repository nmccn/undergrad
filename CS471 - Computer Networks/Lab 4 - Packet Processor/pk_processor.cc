//
// Created by Phil Romig on 11/13/18.
//

#include "packetstats.h"

// ****************************************************************************
// * pk_processor()
// *  Most/all of the work done by the program will be done here (or at least it
// *  it will originate here). The function will be called once for every
// *  packet in the savefile.
// ****************************************************************************
void pk_processor(u_char *user, const struct pcap_pkthdr *pkthdr, const u_char *packet) {

    resultsC* results = (resultsC*)user;
    results->incrementTotalPacketCount();
    DEBUG << "Processing packet #" << results->packetCount() << ENDL;
    char s[256]; memset(s,0,256); memcpy(s,ctime(&(pkthdr->ts.tv_sec)),strlen(ctime(&(pkthdr->ts.tv_sec)))-1);
    TRACE << "\tPacket timestamp is " << s;
    TRACE << "\tPacket capture length is " << pkthdr->caplen ;
    TRACE << "\tPacket physical length is " << pkthdr->len ;

    // ***********************************************************************
    // * Process the link layer header
    // *  Hint -> use the ether_header structure defined in
    // ***********************************************************************
	struct ether_header *macHdr = (struct ether_header*)packet;
	struct iphdr *ipHdr;
	int next_level = -1;
	u_int64_t sourceMac = 0;
	memcpy(&sourceMac, &(macHdr->ether_shost),6);
	uint64_t destMac = 0;
	memcpy(&destMac, &(macHdr->ether_dhost),6);
	// Put the src/dst addr in set
	results->newSrcMac(sourceMac);
	results->newDstMac(destMac);

	if (ntohs(macHdr->ether_type) >= 1536) {
		// Add the packet to Ethernet(II)
		results->newEthernet(pkthdr->len);
	}
	else {
		// Add packet to OtherLink
		results->newOtherLink(pkthdr->len);
		return;
	}
	
    	// *******************************************************************
    	// * If it's an ethernet packet, extract the src/dst address and  
    	// * find the ethertype value to see what the next layer is.
	// * 
	// * If it's not an ethernet packet, count is as "other" and your done
	// * with this packet.
    	// *******************************************************************
	


    // ***********************************************************************
    // * Process the network layer
    // ***********************************************************************

    	// *******************************************************************
	// *  Use ether_type to decide what the next layer is.  You
	// *  If it's ARP or IPv6 count it and you are done with this packet.
	// * 
	// * If it's IPv4 extract the src and dst addresses and find the
	// * protocol field to see what the next layer is.  
	// * 
	// * If it's not ARP, IPv4 or IPv6 count it as otherNetwork.
    	// *******************************************************************
	
	// We care about IPv4, IPv6, and ARP. From ethernet.h:
	int next_type = ntohs(macHdr->ether_type);
	if (next_type == ETHERTYPE_IP) {
		// Extract src/dst and find the protocol field to see what next layer is
		packet += sizeof(struct ether_header);
		ipHdr = (struct iphdr *)(packet);
		// Add the src/dst IP addresses to the set
		results->newSrcIPv4(ipHdr->saddr);
		results->newDstIPv4(ipHdr->daddr);
		// Grab the protocol field
		next_level = (int)ipHdr->protocol;	
		results->newIPv4(pkthdr->len);
	}
	else if (next_type == ETHERTYPE_IPV6) {
		results->newIPv6(pkthdr->len);
		return;
	}
	else if (next_type == ETHERTYPE_ARP) {
		results->newARP(pkthdr->len);
		return;
	}
	else {
		results->newOtherNetwork(pkthdr->len);
		return;
	}

    // ***********************************************************************
    // * Process the transport layer header
    // ***********************************************************************

    	// *******************************************************************
	// * If the packet is an IPv4 packet, then use the Protcol field
	// * to find out what the next layer is.
	// * 
	// * If it's ICMP, count it and you are done with this packet.
	// *
	// * If it's UDP or TCP, decode the transport hearder to extract
	// * the src/dst ports and TCP flags if needed.
	// *
	// * If it's not ICMP, UDP or TCP, count it as otherTransport
    	// *******************************************************************

	// Check the protocol field
	if (next_level) {
		unsigned int ipHdr_length = ipHdr->ihl*4;
		packet += ipHdr_length;
		// code for UDP
		if (next_level == 17) {
			struct udphdr *udpHdr = (struct udphdr *)(packet);	
			results->newUDP(pkthdr->len);
			results->newSrcUDP(ntohs(udpHdr->source));
			results->newDstUDP(ntohs(udpHdr->dest));
			return;
		}
		// code for TCP
		else if (next_level == 6) {
			struct tcphdr *tcpHdr = (struct tcphdr *)(packet);
			results->newTCP(pkthdr->len);
			// Ports
			results->newSrcTCP(ntohs(tcpHdr->source));
			results->newDstTCP(ntohs(tcpHdr->dest));
			// Flags
			if (tcpHdr->syn) {
				results->incrementSynCount();
			}
			else if (tcpHdr->fin) {
				results->incrementFinCount();
			}
			return;
		}
		// code for ICMP
		else if (next_level == 1) {
			results->newICMP(pkthdr->len);
			return;
		}
		// code for Other Transport
		else {
			results->newOtherTransport(pkthdr->len);
			return;
		}
	}
    return;
}
