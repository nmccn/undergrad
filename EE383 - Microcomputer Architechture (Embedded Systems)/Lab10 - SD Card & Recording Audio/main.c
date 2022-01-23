//--------------------------------------------------------------------
// Name:            John Capper & Nicholas McClellan
// Date:            Spring 2020
// Purp:            Lab10
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
#include "sdCard.h"

//------------------------------------------------------------------------
// If you can get the inttypes.h include to compiler into this project 
// you can print 32-bit unsigned integer variables using:
// printf("Block address: 0x%08" PRIx32 "\r\n",blockAddress);)
//
// The include lives at:
// C:\Program Files (x86)\Microchip\xc8\v2.00\pic\include\c99
//
//  #include <c99/inttypes.h>
//  #include <inttypes.h>
//
// If you can figure this out, give me a shout: coulston@gmail.com
// I've wasted about 2 hours trying to make this happen on
// Product Version: MPLAB X IDE v5.05
// XC8 ver 2.0
//
// Enable C99: Edit -> Project Properties -> Linker -> C99
//#include <inttypes.h>
//------------------------------------------------------------------------
#pragma warning disable 328
#pragma warning disable 373
#pragma warning disable 520     
#pragma warning disable 1498

#pragma warning disable 2029
#pragma warning disable 2030

/* Helpers */
void initializeAll(void);
void printMenu();
void doSDInit(void);

void myTMR0ISR(void);

#define BLOCK_SIZE                  512
#define RATE                        1600
#define RATE_CHANGE                 160
#define MAX_NUM_BLOCKS              512
#define SINE_WAVE_ARRAY_LENGTH      26

#define RED 0
#define BLUE 1

// Large arrays need to be defined as global even though you may only need to 
// use them in main.  This quirk will be important in the next two assignments.
uint8_t     sdCardBuffer[BLOCK_SIZE]; 

uint16_t    sampleRate = RATE;

/* For ISR */
uint8_t     blueBuffer[BLOCK_SIZE];
uint8_t     redBuffer[BLOCK_SIZE];
uint8_t     redBufferFull = false;
uint8_t     blueBufferFull = false;
uint8_t     redBufferIsEmpty = true;
uint8_t     blueBufferIsEmpty = true;
uint8_t     recording = false;
uint8_t     playingSound = false;

//----------------------------------------------
// Main "function"
//----------------------------------------------
void main (void) {

    uint8_t     status;
    uint16_t    blockIndex = 0;
    uint16_t    i;
    uint32_t    readAddress = 0x00000000;     
    uint32_t    address = 0;  
    char        cmd, letter;
    
    uint16_t    blocksWritten = 0;
    
    const uint8_t   sin[SINE_WAVE_ARRAY_LENGTH] = {128,	159,	187,	213,	233,	248,	255,	255,	248,	233,	213,	187,	159,	128,	97,	69,	43,	23,	8,	1,	1,	8,	23,	43,	69,	97};
    
    ADCON0bits.GO_NOT_DONE = 1; // Start analog to digital converter
    
    letter = '0';
    
    initializeAll();

	for(;;) {
        
		if (EUSART1_DataReady) {			// wait for incoming data on USART
            cmd = EUSART1_Read();
			switch (cmd) {		// and do what it tells you to do

			//--------------------------------------------
			// Reply with help menu
			//--------------------------------------------
			case '?':
                printf("\tPlay length in blocks: %u\r\n", blocksWritten);
                printf("\tsdCardAddress: %04x", readAddress>>16); printf(":"); printf("%04x", readAddress&0X0000FFFF); printf("\r\n");
                printf("Sample Rate: %u us", RATE/16);
				printMenu();
				break;

			//--------------------------------------------
			// Reply with "k", used for PC to PIC test
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
            // Init SD card to get it read to perform read/write
            // Will hang in infinite loop on error.
            //--------------------------------------------    
            case 'i':
                doSDInit();
                break;
                
            //--------------------------------------------
            // Increase or decrease read address.
            //--------------------------------------------                 
            case 'A':
            case 'a':
                if (cmd == 'a') {
                    readAddress -= BLOCK_SIZE;
                    printf("Decreased ");
                } else{
                    readAddress += BLOCK_SIZE;                
                    printf("Increased ");
                }
                printf("SD card address:  ");
                printf("%04x", readAddress>>16); printf(":"); printf("%04x", readAddress&0X0000FFFF); printf("\r\n");
                break;     
                
            //--------------------------------------------
			// r: read a block of 512 bytes from SD card.
			//--------------------------------------------
            case 'r':
                SDCARD_ReadBlock(readAddress,sdCardBuffer);
                printf("Read block: \r\n");                               
                printf("    Address:    ");
                printf("%04x", readAddress>>16); printf(":"); printf("%04x", readAddress&0X0000FFFF);    printf("\r\n");
                hexDumpBuffer(sdCardBuffer);
                break;  
            
            /* NEW STUFF STARTS HERE */    
                
            //--------------------------------------------
			// 1: write a perfect 26 value sine wave to the SD card
			//--------------------------------------------
            case '1':
                address = 0;    //Start at beginning
                blockIndex = 0;
                uint8_t sinIndex = 0;
                
                printf("Press any key to start storing sine waves\r\n");
                while(!EUSART1_DataReady); // Wait until key is pressed to begin recording
                (void) EUSART1_Read();  // Clear flag
                
                printf("Press any key to stop storing sine waves\r\n");
                blocksWritten = 0;
                while(!EUSART1_DataReady && (blockIndex < MAX_NUM_BLOCKS)) {
                    for(i = 0; i < BLOCK_SIZE; i++) {
                        sdCardBuffer[i] = sin[sinIndex % SINE_WAVE_ARRAY_LENGTH]; // With wraparound
                        sinIndex++;
                    }
                    SDCARD_WriteBlock(address, sdCardBuffer);
                    while ((status = SDCARD_PollWriteComplete()) == WRITE_NOT_COMPLETE);
                    address += BLOCK_SIZE;
                    blockIndex++;
                    blocksWritten++;
                }
                (void) EUSART1_Read();  // Clear flag
                
                printf("%u blocks were stored\r\n", blockIndex);

                break;
                
            //--------------------------------------------
            // Increase or decrease the sample rate by 10 us
            //--------------------------------------------                 
            case '+':
            case '-':
                printf("Sampling rate ");
                if (cmd == '+') {
                    sampleRate += RATE_CHANGE;
                    printf("increased to %u\r\n", sampleRate);

                } else{
                    if(sampleRate - RATE_CHANGE > 0) {
                        sampleRate -= RATE_CHANGE;
                        printf("decreased to %u\r\n", sampleRate);
                    }
                    else
                        printf("Cannot decrease sampling rate below 20us\r\n");
                }
                printf("%u\r\n", sampleRate);

                break;   
                
            //--------------------------------------------
			// W: Write microphone => SD card at 1600 us
			//--------------------------------------------
            case 'W':
                address = 0;
                
                printf("Press any key to start recording audio and press any key to stop recording.\r\n");
                while(!EUSART1_DataReady); // Wait until key is pressed to begin recording
                (void) EUSART1_Read();  //Clear Flag
                
                recording = true; //Tells ISR to start filling buffer
                printf("Recording started\r\n");
                
                blocksWritten = 0;
                /* Record until key is pressed to stop recording */
                while(!EUSART1_DataReady) {
                    while(redBufferFull == false);  // Wait for ISR to fill red buffer
                    SDCARD_WriteBlock(address, redBuffer);
                    while((status = SDCARD_PollWriteComplete()) == WRITE_NOT_COMPLETE);
                    redBufferFull =  false;
                    address += BLOCK_SIZE;  //Advance to next block
                    blocksWritten++;    // One more block has been written
                    
                    while(blueBufferFull == false);  // Wait for ISR to fill blue buffer
                    SDCARD_WriteBlock(address, blueBuffer);
                    while((status = SDCARD_PollWriteComplete()) == WRITE_NOT_COMPLETE);
                    blueBufferFull =  false;
                    address += BLOCK_SIZE;  //Advance to next block       
                    blocksWritten++;    // One more block has been written
                }
                
                (void) EUSART1_Read();  //Clear Flag
                
                recording = false;  //Tell ISR to stop filling buffer
                printf("Recording stored\r\n");
                break;                                
                
            //--------------------------------------------
			// s: spool memory to a csv file             
			//--------------------------------------------
            case 's':
                blockIndex = 0;                
                
                printf("You may stop spooling at anytime by pressing any key.\r\n");
                
                /* Starting instructions */
                printf("To spool terminal contents into a file follow these instructions:\r\n\r\n");
                printf("Select:     Change settings...\r\n");
                printf("Select:     Logging\r\n");
                printf("Select:     Session logging: All session output\r\n");
                printf("Log file name:  Browse and provide a .csv extension to your file name\r\n");
                printf("Select:     Apply\r\n");
                printf("Press any key to start\r\n");
                
                while(!EUSART1_DataReady); // Wait until key is pressed to start
                
                (void) EUSART1_Read();  // Clear flag
                
                while(!EUSART1_DataReady && (blockIndex < MAX_NUM_BLOCKS)) { //Read until key is pressed to stop
                    SDCARD_ReadBlock(address, blueBuffer); 
                    
                    for (i = 0; i < BLOCK_SIZE; i++)    printf("%d \r\n", blueBuffer[i]);   //Print block
                    
                    /* Advance to next block */
                    address += BLOCK_SIZE;
                    blockIndex++;
                }
                
                (void) EUSART1_Read();  // Clear flag
                
                /* Closing Instructions */
                printf("Spooled %d out of the 512 blocks.\r\n", blockIndex);
                printf("To close the file follow these instructions:\r\n");
                printf("\r\n");
                printf("Right mouse click on the upper left of the PuTTY window\r\n");
                printf("Select:     Change settings...\r\n");
                printf("Select:     Logging\r\n");
                printf("Select:     Session  logging: None\r\n");
                printf("Select:     Apply\r\n");
                
                break;
                
                
            //--------------------------------------------
			// Playback audio from SD Card
			//--------------------------------------------
            case 'P':
                address = 0;
                playingSound = true;
                printf("Playing has started\r\n");
                for (i = 0; i < blocksWritten; i++){
                    if(EUSART1_DataReady){  // Stop playing if key pressed
                        (void) EUSART1_Read();  // Clear flag
                        break;
                    }
                    if(i % 2 == 0) {    //Even iterations use red
                        while(redBufferIsEmpty == false);   // Wait for buffer to empty
                        SDCARD_ReadBlock(address, redBuffer);
                        redBufferIsEmpty = false;
                    }
                    else {    //Odd iterations use blue
                        while(blueBufferIsEmpty == false);   // Wait for buffer to empty
                        SDCARD_ReadBlock(address, blueBuffer);
                        blueBufferIsEmpty = false;
                    }
                    address += BLOCK_SIZE;
                }
                playingSound = false;
                printf("Playing has ended\r\n");
                
                
                break;
                    
			//--------------------------------------------
			// If something unknown is hit, tell user
			//--------------------------------------------
			default:
				printf("Unknown key %c\r\n",cmd);
				break;
			} // end switch
            
		}	// end if
	} // end while 
} // end main


//----------------------------------------------
// As configured, we are hoping to get a toggle
// every 100us - this will require some work.
//
// You will be starting an ADC conversion here and
// storing the results (when you reenter) into a global
// variable and setting a flag, alerting main that 
// it can read a new value.
//----------------------------------------------
#define WASTING_TIME    true
#define BASIC_TIME      false

void myTMR0ISR(void){
    static uint8_t currentColor = RED;
    static uint16_t i = 0;
    static uint8_t adcResult;
    
    ADCON0bits.GO_NOT_DONE = 1;
    adcResult = ADRESH;
    
    if(recording) {
        if(currentColor == RED) {
            redBuffer[i] = adcResult;
            i++;
            if(i == BLOCK_SIZE) {
                i = 0;
                redBufferFull = true;
                currentColor = BLUE;
            }
        } else {
            blueBuffer[i] = adcResult;
            i++;
            if(i == BLOCK_SIZE) {
                i = 0;
                blueBufferFull = true;
                currentColor = RED;
            }
        }
    }
    
    if (playingSound){
        if (currentColor == RED){
            EPWM1_LoadDutyValue(redBuffer[i]);
            i++;
            if(i == BLOCK_SIZE){
                i = 0;
                redBufferIsEmpty = true;
                currentColor = BLUE;
            }
        }
        else {
            EPWM1_LoadDutyValue(blueBuffer[i]);
            i++;
            if(i == BLOCK_SIZE){
                i = 0;
                blueBufferIsEmpty = true;
                currentColor = RED;
            }
        }
        
    }
    
    
    TMR0_WriteTimer(TMR0_ReadTimer() + (0x10000 - sampleRate));   // More accurate

    INTCONbits.TMR0IF = 0;  // Clear Flag

}


void printMenu()  {
        printf("-------------------------------------------------\r\n");
        printf("\r\n");
        printf("-------------------------------------------------\r\n");
        printf("?: help menu\r\n");
        printf("o: k\r\n");
        printf("Z: Reset processor\r\n");                     
        printf("z: Clear the terminal\r\n");
        printf("-------------------------------------------------\r\n");
        printf("i: Initialize SD card\r\n");
        printf("-------------------------------------------------\r\n");
        printf("a/A: decrease/increase read address\r\n");
        printf("r: read a block of 512 bytes from SD card\r\n");
        printf("1: write perfect 26 value sine wave to 128 blocks\r\n");
        printf("-------------------------------------------------\r\n");
        printf("s: spool memory to a csv file\r\n");
        printf("-------------------------------------------------\r\n");
        printf("+/-: Increase/Decrease the sample rate by 10 us\r\n");
        printf("P: Play from SD card to PWM -> LPF -> Audio\r\n");
        printf("W: Write microphone => SD card \r\n");
        printf("-------------------------------------------------\r\n");
}

void initializeAll(void) {
    SYSTEM_Initialize();
    CS_SetHigh();
    
    // Provide Baud rate generator time to stabilize before splash screen
    TMR0_WriteTimer(0x0000);
    INTCONbits.TMR0IF = 0;
    while (INTCONbits.TMR0IF == 0);
    
    TMR0_SetInterruptHandler(myTMR0ISR);
    
    INTERRUPT_GlobalInterruptEnable();    
    INTERRUPT_PeripheralInterruptEnable();

	printf("Development Board\r\n");
	printf("Lab 10 terminal\r\n");
    printf("Audio recording and playback \r\n");
	printf("\r\n> ");                       // print a nice command prompt
}

void doSDInit(void) {
    printf("Make sure SD card is properly inserted.\r\n");
    printf("Press any key to continue.\r\n");
    SPI2_Close();
    SPI2_Open(SPI2_DEFAULT);
    while (EUSART1_DataReady == false);
    (void) EUSART1_Read();                  // clear character for next menu action
    SDCARD_Initialize(true);
}

