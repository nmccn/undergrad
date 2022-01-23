//--------------------------------------------------------------------
// Name:            Chris Coulston
// Date:            Fall 2019
// Purp:            inLab 6
//
// Assisted:        The entire class of EENG 383
// Assisted by:     Microchips 18F26K22 Tech Docs 
//-
//- Academic Integrity Statement: I certify that, while others may have
//- assisted me in brain storming, debugging and validating this program,
//- the program itself is my own work. I understand that submitting code
//- which is the work of other individuals is a violation of the course
//- Academic Integrity Policy and may result in a zero credit for the
//- assignment, or course failure and a report to the Academic Dishonesty
//- Board. I also understand that if I knowingly give my original work to
//- another individual that it could also result in a zero credit for the
//- assignment, or course failure and a report to the Academic Dishonesty
//- Board.
//------------------------------------------------------------------------
#include "mcc_generated_files/mcc.h"
#include <string.h>
#pragma warning disable 373
#pragma warning disable 520     
#pragma warning disable 751
#pragma warning disable 1498

#define LED_ON      25 
#define LED_OFF     0
#define MAX_BUFFER_SIZE 20


void myEUSART2ISR(void);
char IRreceiveBuffer[MAX_BUFFER_SIZE];
uint8_t receiveBusy = false;
uint8_t receiveNewMessage = false;

uint8_t checkSumTx = 0;
uint8_t checkSumRx = 0;
uint8_t mask;

char IRtransmitBuffer[MAX_BUFFER_SIZE];
void transmitCharacterOverIR(char letter, uint16_t baudRate);
//----------------------------------------------
// Main "function"
//----------------------------------------------
void main (void) { 
    SYSTEM_Initialize();
    EUSART2_SetRxInterruptHandler(myEUSART2ISR);
    INTERRUPT_PeripheralInterruptEnable();
    INTERRUPT_GlobalInterruptEnable();
    
    char message[MAX_BUFFER_SIZE];
    
    uint8_t  i;
    uint8_t  baudRateSelected = 1;
    char cmd;
    char leadingBit = '0';
    uint16_t bitPeriod[5] = {53333, 13333, 6666, 1666, 833};

    EPWM2_LoadDutyValue(LED_OFF);

//    PIE3bits.RC2IE = 0;
//    PIE3bits.RC2IE = 1; 
    
    // Since EUSART2 is double buffered, clear out any garbage with two reads from those buffers
    if (EUSART2_DataReady) (void) EUSART2_Read();
    if (EUSART2_DataReady) (void) EUSART2_Read();
    
    // Delay so the Baud rate generator is stable and prints the splash screen correctly
    TMR1_WriteTimer(0);
    PIR1bits.TMR1IF = 0;
    while (TMR1_HasOverflowOccured() == false);

	printf("Dev'20 Board\r\n");
    printf("Lab 6 - Receive and decode an IR packet\r\n");
    printf("Install a jumper from RC4 to RB7 only after unplugging PICKit4\r\n");
	printf("\r\n> ");                      


	for(;;) {

		if (EUSART1_DataReady) {			// wait for incoming data on USART
            cmd = EUSART1_Read();
			switch (cmd) {		// and do what it tells you to do

			//--------------------------------------------
			// Reply with help menu
			//--------------------------------------------
			case '?':
				printf("-------------------------------------------------\r\n");
                switch(baudRateSelected) {
                    case 0: printf("300 Baud\r\n"); break;
                    case 1: printf("1200 Baud\r\n"); break;
                    case 2: printf("2400 Baud\r\n"); break;
                    case 3: printf("9600 Baud\r\n"); break;
                    case 4: printf("19200 Baud\r\n"); break;
                    default: printf("1200 Baud\r\n"); break;
                }
				printf("-------------------------------------------------\r\n");
                printf("?: help menu\r\n");
				printf("o: k\r\n");
                printf("Z: Reset processor\r\n");                     
                printf("z: Clear the terminal\r\n"); 
                printf("b: set the Baud rate of the sent characters\r\n");
                printf("r: reset EUSART2\r\n");
                printf("m: Enter in transmit Message\r\n");
                printf("S: Send message in foreground\r\n");
                printf("R: Receive message using EUSART2 ISR via IR decoder\r\n");
                printf("r: reset EUSART2\r\n");                
                printf("-------------------------------------------------\r\n");
				break;

			//--------------------------------------------
			// Reply with "ok", used for PC to PIC test
			//--------------------------------------------
			case 'o':
				printf("o:	ok\r\n");
				break;                
                
            //--------------------------------------------
            // Reset the processor after clearing the terminal
            //--------------------------------------------                      
            case 'Z':
                for (i=0; i<40; i++) printf("\n");
                RESET();                    
                break;

            //--------------------------------------------
            // Clear the terminal
            //--------------------------------------------                      
            case 'z':
                for (i=0; i<40; i++) printf("\n");                            
                break;                  

            //--------------------------------------------
            // Set the Baud rate - use MCC EUSART2 configuration register tab            
            //--------------------------------------------                    
            case 'b':
                printf("Choose the index of the target baud rate\r\n");
                printf("0: 300 baud\r\n");
                printf("1: 1200 baud\r\n");
                printf("2: 2400 baud\r\n");
                printf("3: 9600 baud\r\n");
                printf("4: 19200 baud\r\n");
                while(EUSART1_DataReady);
                baudRateSelected = EUSART1_Read() - '0';
                switch(baudRateSelected) {
                    case 0: SPBRGH2 = 0xD0;      SPBRG2 = 0x54;   break;
                    case 1: SPBRGH2 = 0x34;      SPBRG2 = 0x14;   break;
                    case 2: SPBRGH2 = 0x1A;      SPBRG2 = 0x09;   break;
                    case 3: SPBRGH2 = 0x06;      SPBRG2 = 0x81;   break;
                    case 4: SPBRGH2 = 0x03;      SPBRG2 = 0x40;   break;
                    default: SPBRGH2 = 0x34;      SPBRG2 = 0x14;  break;                    
                }
                printf("Baud rate assigned %02x:%02x\r\n",SPBRGH2,SPBRG2);
                break;
            
            //--------------------------------------------
			// reset EUSART2 in case it needs doing
			//--------------------------------------------                
            case 'r':             
                RCSTA2bits.CREN = 0;        
                RCSTA2bits.CREN = 1;
                printf("Just reset EUSART2\r\n");
                break;
                
            //--------------------------------------------
			// Has user enter string
			//--------------------------------------------                
            case 'm':          
                printf("Enter a message, hit return when done.\r\n");
                uint8_t index = 0;
                checkSumTx = 0;
                while(EUSART1_DataReady == true);   //Waits until we can input
                while( ((IRtransmitBuffer[index] = EUSART1_Read()) !=  '\r') && (index < MAX_BUFFER_SIZE - 2) ) {
                    printf("%c", IRtransmitBuffer[index]);
                    message[index] = EUSART1_Read();
                    checkSumTx += IRtransmitBuffer[index];
                    index++;
                }
                printf("\r\nCreated\r\n");
                printf("\tMessage: %s\r\n", IRtransmitBuffer);
                printf("\tcheckSum: %u\r\n", checkSumTx);
                
                //adding the end bits, null terminating char and checksum
                message[index] = '\0';
                message[index+1] = checkSumTx;
                

                break;
            
            //--------------------------------------------
			// Transmit the bits of a ASCII character, LSB first including
            // a start and stop bit.
			//--------------------------------------------  
            case 'S':
                // Preface character with a '0' bit
//                EPWM2_LoadDutyValue(LED_ON);
//                TMR1_WriteTimer(0x10000 - bitPeriod[baudRateSelected]);
//                PIR1bits.TMR1IF= 0;
//                while (TMR1_HasOverflowOccured() == false);
                i = 0;
                char letter;
                while((letter = message[i]) != '\0') {
                    transmitCharacterOverIR(message[i], bitPeriod[baudRateSelected]);
                    i++;
                }
                
                transmitCharacterOverIR(message[i], bitPeriod[baudRateSelected]);
                transmitCharacterOverIR(message[i+1], bitPeriod[baudRateSelected]);
                
                printf("Transmitted\r\n");
                printf("\tMessage: %s\r\n", IRtransmitBuffer);
                printf("\tcheckSum: %u\r\n", checkSumTx);
                
                
                break;
                
            //--------------------------------------------
			// Read the a character from EUSART2 FIFO
            // It's safe to use EUSART2_Read because RC2IF = 1
			//--------------------------------------------

            case 'R':                
                if(receiveNewMessage == true) {
                    printf("Received\r\n");
                    printf("\tMessage: %s", IRreceiveBuffer);
                    printf("\tcheckSum: %u", checkSumRx);
                    checkSumRx = 0;
                    memset(IRreceiveBuffer, 0, MAX_BUFFER_SIZE);
                }
                else {
                    printf("No message, receiveNewMessage = false\r\n");
                }
                receiveNewMessage = false;
				break;
            //--------------------------------------------
			// If something unknown is hit, tell user
			//--------------------------------------------
			default:
				printf("Unknown key %c\r\n",cmd);
				break;
			} // end switch            
		} // end if
	} // end while 
} // end main

void myEUSART2ISR(void) {
    PIE3bits.TX2IE = 0;
    static uint8_t state = 0;
    static uint8_t index = 0;
    if(receiveNewMessage == false) {
        char input = RCREG2;
        checkSumRx += input;
        switch(state) {
            case 0:     //Started receiving characters
                IRreceiveBuffer[index] = input;
                state = 1;
                index++;
                break;
            case 1:     //Receiving characters
                IRreceiveBuffer[index] = input;
                if(input == '\0')
                    state = 2;
                index++;
                break;
            case 2:     //Finished receiving characters
                IRreceiveBuffer[index] = input;
                state = 0;
                index = 0;
                receiveNewMessage = true;
                break;
            default:
                printf("OOPS\r\n");
                break;
        }
        
    }
}

void transmitCharacterOverIR(char letter, uint16_t baudRate) {
    // Preface character with a '0' bit
    EPWM2_LoadDutyValue(LED_ON);
    TMR1_WriteTimer(0x10000 - baudRate);
    PIR1bits.TMR1IF= 0;
    while (TMR1_HasOverflowOccured() == false);

    // LSB first
    mask = 0b00000001;   
    while (mask != 0) {
        if ((letter & mask) != 0)   EPWM2_LoadDutyValue(LED_OFF);
        else                        EPWM2_LoadDutyValue(LED_ON);
        mask = mask << 1;
        TMR1_WriteTimer(0x10000 - baudRate);
        PIR1bits.TMR1IF= 0;
        while (TMR1_HasOverflowOccured() == false);
    } 

    // Need a stop bit to break up successive bytes
    EPWM2_LoadDutyValue(LED_OFF);
    TMR1_WriteTimer(0x10000 - baudRate);
    PIR1bits.TMR1IF= 0;
    while (TMR1_HasOverflowOccured() == false);

    letter += 1;
}