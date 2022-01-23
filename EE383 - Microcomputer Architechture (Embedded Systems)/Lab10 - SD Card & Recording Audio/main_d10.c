// Name:            Jesus Ramirez, Devin Buzzetta
// Date:            Fall 2019
// Purp:            inLab09
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

void myTMR0ISR(void);
void doSDInit(void);
 
#define BLOCK_SIZE          512
#define MAX_NUM_BLOCKS      512
#define SINE_WAVE_ARRAY_LENGTH 26
#define RED 0
#define Blue 1
uint8_t blueBuff[512];
uint8_t redBuff[512];
uint8_t sdBuff[26];
uint16_t sampleRate = 1600;
uint8_t redBuffIsFull = false;
uint8_t blueBuffIsFull = false;
uint8_t redBufferIsEmpty = true;
uint8_t blueBufferIsEmpty = true;
uint16_t recording = false;
uint8_t playingSound = false;

// Large arrays need to be defined as global even though you may only need to 
// use them in main.  This quirk will be important in the next two assignments.
uint8_t     sdCardBuffer[BLOCK_SIZE];  
        
//----------------------------------------------
// Main "function"
//----------------------------------------------
void main (void) {
    
    uint8_t     status;
    uint16_t    i;    
    uint32_t    sdCardAddress = 0x00000000; 
    uint32_t    address = 0;
    uint8_t block;
    uint16_t blockCounter = 0;
    char        cmd, letter;
    uint16_t blockIndex = 0;
    uint8_t j = 0;
    const uint8_t   sin[SINE_WAVE_ARRAY_LENGTH] = {128,	159,	187,	213,	233,	248,	255,	255,	248,	233,	213,	187,	159,	128,	97,	69,	43,	23,	8,	1,	1,	8,	23,	43,	69,	97};
    letter = '0';
    
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
	printf("inLab 09 terminal\r\n");
    printf("SD card testing\r\n");
	printf("\r\n> ");                       // print a nice command prompt

	for(;;) {

		if (EUSART1_DataReady) {			// wait for incoming data on USART
            cmd = EUSART1_Read();
			switch (cmd) {		// and do what it tells you to do

			//--------------------------------------------
			// Reply with help menu
			//--------------------------------------------
			case '?':
				printf("\r\n-------------------------------------------------\r\n");
                printf("SD card address:  ");
                printf("%04x", sdCardAddress>>16); printf(":"); printf("%04x", sdCardAddress&0X0000FFFF); printf("\r\n");
                printf("-------------------------------------------------\r\n");
                printf("?: help menu\r\n");//done
				printf("o: k\r\n");//done
                printf("Z: Reset processor\r\n");               //done      
                printf("z: Clear the terminal\r\n");      //done              
                printf("-------------------------------------------------\r\n");
                printf("i: Initialize SD card\r\n");//done
                //printf("t: send a Test character over SPI\r\n");
                printf("-------------------------------------------------\r\n");
                printf("a/A decrease/increase read address\r\n");//done
                printf("r: read a block of %d bytes from SD card\r\n", BLOCK_SIZE);//done
                printf("1: write a perfect 26 value sine wave to the 128 blocks\r\n");//need
                printf("-------------------------------------------------\r\n");
                printf("=/-: Increase/Decrease the sample rate by 10 us\r\n");//Done
                printf("W: read from mic and send to SD card\r\n", BLOCK_SIZE); //Done
                printf("s: spool memory to a csv file\r\n"); //Done
                printf("P: Play from SD card to PWM -> LPF -> Audio\r\n"); //Need
                printf("-------------------------------------------------\r\n");
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
            // Clear the terminal
            //--------------------------------------------                      
            case 't':                
//                printf("send: %02x  received: %02x\r\n", letter, SPI2_Exchange8bit(letter));
                letter += 1;
                break;                 
                
            //-------------------------------------------- 
            // Init SD card to get it read to perform read/write
            // Will hang in infinite loop on error.
            //--------------------------------------------    
            case 'i':
                doSDInit();
                break;
                
            //--------------------------------------------
            // Increase or decrease block address
            //--------------------------------------------                 
            case 'A':
            case 'a':
                if (cmd == 'a') {
                    sdCardAddress -= BLOCK_SIZE;
                    printf("Decreased ");
                } else{
                    sdCardAddress += BLOCK_SIZE;                
                    printf("Increased ");
                }
                printf("SD card address:  ");
                printf("%04x", sdCardAddress>>16); printf(":"); printf("%04x", sdCardAddress&0X0000FFFF); printf("\r\n");
                break;                              
                
            //--------------------------------------------
			// w: write a block of BLOCK_SIZE bytes to SD card
			//--------------------------------------------
            case 'W':
                 address = 0;
                 recording = true;
                 printf("Press any key to start recording\r\n");
                 while (EUSART1_DataReady == false);
                 (void) EUSART1_Read();
                 while (EUSART1_DataReady == false){
                     while(redBuffIsFull == false);
                     SDCARD_WriteBlock(address, redBuff);
                     while((status = SDCARD_PollWriteComplete()) == WRITE_NOT_COMPLETE);
                     redBuffIsFull = false;
                     address += 512;
                     while(blueBuffIsFull == false);
                     SDCARD_WriteBlock(address, blueBuff);
                     while((status = SDCARD_PollWriteComplete()) == WRITE_NOT_COMPLETE);
                     address += 512;
                     blueBuffIsFull = false;
                 }
                 recording = false;
                 break;

                /*for (i=0; i<BLOCK_SIZE; i++) sdCardBuffer[i] = 255-i;
                SDCARD_WriteBlock(sdCardAddress, sdCardBuffer);
                while ((status = SDCARD_PollWriteComplete()) == WRITE_NOT_COMPLETE);   
                
                printf("Write block:\r\n");
                printf("    Address:    ");
                printf("%04x", sdCardAddress>>16); printf(":");  printf("%04x", sdCardAddress&0X0000FFFF);    printf("\r\n");
                printf("    Status:     %02x\r\n",status);                
                break;                                
                */
            //--------------------------------------------
			// r: read a block of BLOCK_SIZE bytes from SD card                
			//--------------------------------------------
            case 'P':
                address = 0;
                //uint32_t addressA = 0x00000000;
                uint16_t debugCounter = 132;
                
                printf("test\r\n");
                SDCARD_ReadBlock(address,redBuff); //THIS NEEDS TO WORK. CURRENTLY GETS STUCK IN AN INFINITE LOOP
                printf("%04x", address>>16); printf(":"); printf("%04x", address&0X0000FFFF);    printf("\r\n");
                //hexDumpBuffer(redBuff);
                printf("test2\r\n");
                address += 512;
                
                playingSound = true;// We need to load the buffer before trying to read from it.
                for (block = 0; block < 128; block += 2){
                    printf("%d \r\n", debugCounter);
                    debugCounter += 1;
                    while(redBufferIsEmpty == false);
                    //printf("oof\r\n");
                    SDCARD_ReadBlock(address, redBuff);
                    //printf("oof2\r\n");
                    //hexDumpBuffer(redBuff);
                    //while((status = SDCARD_PollWriteComplete()) == WRITE_NOT_COMPLETE);
                    redBufferIsEmpty = false;
                    address += 512;
                    //printf("asdf\r\n");
                    while(blueBufferIsEmpty == false);
                    SDCARD_ReadBlock(address, blueBuff);
                    //hexDumpBuffer(blueBuff);
                    //while((status = SDCARD_PollWriteComplete()) == WRITE_NOT_COMPLETE);
                    address += 512;
                    blueBufferIsEmpty = false;
                    
                }
                playingSound = false;
                break;
                    
            case 'r':                  
                SDCARD_ReadBlock(sdCardAddress,sdCardBuffer);
                printf("Read block: \r\n");                               
                printf("    Address:    ");
                printf("%04x", sdCardAddress>>16); printf(":"); printf("%04x", sdCardAddress&0X0000FFFF);    printf("\r\n");
                hexDumpBuffer(sdCardBuffer);
                break;
                
            case '+':
                sampleRate += 160;
                printf("sampleRate is now %d \r\n", sampleRate);
                break;
            
            case '-':
                if ((sampleRate - 360) <= 0){
                    printf("Sample can't be less than 20 us.");
                }
                else{
                    sampleRate -= 160;
                    printf("sampleRate is now %d \r\n", sampleRate);
                }
                break;
                
            case '1':
                address = 0;
                uint16_t thisCounter = 0;
                while (blockCounter <128){
                    for (uint16_t i = 0; i <512; i++){
                        sdBuff[i] = sin[j];
                        j += 1;
                        if (j >= 26){
                            j = 0;
                            
                        }
                    }
                    
                    SDCARD_WriteBlock(address, sdBuff);
                    thisCounter += 1;
                    printf("%d\r\n",thisCounter);
                    printf("THIS WORKED\r\n\r\n");
                    while ((status = SDCARD_PollWriteComplete()) == WRITE_NOT_COMPLETE);
                    address += 512;
                    blockCounter += 1;
                }
                (void) EUSART1_Read();
                printf("%d",address);
                break;
                
            case 's':
                address = 0;
                blockIndex = 0;
                printf("You may terminate spooling at anytime with a keypress.\r\n");
                printf("To spool terminal contents into a file follow these instructions:\r\n");
                printf("\r\n");
                printf("Right mouse click on the upper left of the PuTTY window\r\n");
                printf("Select:     Change settings...\r\n");
                printf("Select:     Logging\r\n");
                printf("Select:     Session logging: All session output\r\n");
                printf("Log file name:  Browse and provide a .csv extension to your file name\r\n");
                printf("Select:     Apply\r\n");
                printf("Press any key to start\r\n");
                
                while (EUSART1_DataReady == false);
                (void) EUSART1_Read();
                while (EUSART1_DataReady == false){
                    SDCARD_ReadBlock(address, blueBuff);
                    for (uint16_t v = 0; v<512; v++){
                        printf("%d \r\n", blueBuff[v]);
                        //printf("Read block: \r\n");                               
                        //printf("    Address:    ");
                        //printf("%04x", address>>16); printf(":"); printf("%04x", address&0X0000FFFF);    printf("\r\n");
                        //hexDumpBuffer(blueBuff);
                    }
                    address += 512;
                    blockIndex += 1;
                }
                //while no key pressed
                //read blocks off of SD card
                //print out the ADC value
                
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
                                                                                               
    
    static uint16_t i = 0;
    static uint8_t color = RED;
    static uint16_t j = 0;
    if (recording == true){
        
    ADCON0bits.GO_NOT_DONE = 1;
    if (color == RED){
        redBuff[i] = ADRESH;
        i += 1;
        if(i >=512){
            i = 0;
            redBuffIsFull = true;
            color = Blue;
        }
    }
    else{
        blueBuff[i] = ADRESH;
        i += 1;
        if(i >=512){
            i = 0;
            blueBuffIsFull = true;
            color = RED;
        }
    }
    }
    
    if (playingSound == true){
        if (color == RED){
            EPWM1_LoadDutyValue(redBuff[j]);
            j += 1;
            if(j >=512){
                j = 0;
                redBufferIsEmpty = true;
                color = Blue;
            }
        }
        else {
            EPWM1_LoadDutyValue(blueBuff[j]);
            j += 1;
            if(j >=512){
                j = 0;
                blueBufferIsEmpty = true;
                color = RED;
            }
        }
        
    }
    
    uint16_t bigOleWasteOfTime;
    TEST_C0_PIN_SetHigh();

    //for (bigOleWasteOfTime=0; bigOleWasteOfTime<40; bigOleWasteOfTime++);    
    //TMR0_WriteTimer(0x10000 - sampleRate);                        // Less accurate    
    TMR0_WriteTimer(TMR0_ReadTimer() + (0x10000 - sampleRate));   // More accurate
    

    INTCONbits.TMR0IF = 0;
    TEST_C0_PIN_SetLow() ;
    
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
