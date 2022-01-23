//*****************************************************************
// Name:    John Capper & Nicholas McClellan
// Date:    Spring 2020
// Purp:    Lab11 - Hall effect with MIDI 
//
// Assisted: Chris Coulston
// Assisted by: Technical documents
//
// Academic Integrity Statement: I certify that, while others may have
// assisted me in brain storming, debugging and validating this program,
// the program itself is my own work. I understand that submitting code
// which is the work of other individuals is a violation of the course
// Academic Integrity Policy and may result in a zero credit for the
// assignment, course failure and a report to the Academic Dishonesty
// Board. I also understand that if I knowingly give my original work to
// another individual that it could also result in a zero credit for the
// assignment, course failure and a report to the Academic Dishonesty
// Board.
//*****************************************************************
#include "mcc_generated_files/mcc.h"
#pragma warning disable 520     
#pragma warning disable 1498

//NOTE FUNCTIONS
#define PLAYNOTE            0x90 
#define NOTEDONE            0x80
#define PLAYINSTRUMENT      0xC0

#define PLAY_DELAY          50000
#define N                   64

#define UNPRESSED           0
#define PRESSED_ACQUIRE     1
#define PRESSED_WAIT        2

#define NUM_NOTES           30

void    putByteSCI(uint8_t writeByte);
void    noteOn(uint8_t cmd, uint8_t pitch, uint8_t velocity);
void    myTMR0ISR(void);

uint8_t collect(uint8_t doPrint);
void    printMenu(void);

uint8_t keyState = UNPRESSED;
uint8_t hallSamples[N];
uint8_t nominalHallUnPressed = 63;
uint8_t nominalHallPressed = 29;
uint8_t delta = 5;
uint16_t sampleRate = 1000;

                //I believe this is what we need for the beginning 30 notes of our Zelda. Took it off of the website from the Inlab for midi pitches.
uint8_t songIndex = 0;
//*****************************************************************
//*****************************************************************
void main(void) {
    uint8_t song[NUM_NOTES] = {0x3C, 0x3C, 0x3E, 0x3C, 0x41, 0x40, 0x3C, 0x3C, 0x3E, 0x3C, 0x43, 0x41};
    
    uint8_t i;
    uint8_t pitch = 64;
    uint8_t instrument=7;
    char    cmd;
    uint8_t velocity;
    
    SYSTEM_Initialize();
    ADC_SelectChannel(HALL_SENSOR);
    
    TMR0_SetInterruptHandler(myTMR0ISR);
    
    INTERRUPT_GlobalInterruptEnable();    
    INTERRUPT_PeripheralInterruptEnable();
    
    printf("Dev'18 Board\r\n");
	printf("Lab 11 terminal \r\n");
    printf("MIDI + Hall effect \r\n");
	printf("\r\n> "); 

    ADC_StartConversion();
    while(!ADC_IsConversionDone());
    nominalHallUnPressed = (ADC_GetConversionResult() >> 8);
	for(;;) {
		if (EUSART1_DataReady) {
            cmd = EUSART1_Read();
			
            switch (cmd) {
                
			//--------------------------------------------
			// Reply with help menu
			//--------------------------------------------
			case '?':
                printMenu();
				break;

            //--------------------------------------------
            // Reply with "k", used for PC to PIC test
            //--------------------------------------------
            case 'o':
                printf("o:      ok\r\n");
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
			// calibrate nominalHallUnPressed
			//--------------------------------------------
            case 'c':
                printf("Hands off the piano, press keyboard key to calibrate nominalHallUnPressed");
                while (!EUSART1_DataReady);
                (void) EUSART1_Read();  // Clear Flag
                
                // Get converted Hall unpressed value
                ADC_StartConversion();
                while(!ADC_IsConversionDone());
                nominalHallUnPressed = ADC_GetConversionResult()>>8;
                
                printf("New nominalHallUnPressed value = %d\r\n",nominalHallUnPressed);
                break;  
                
            //--------------------------------------------
			// calibrate nominalHallPressed
			//--------------------------------------------
            case 'C':
                printf("Press the piano key, press keyboard key to calibrate nominalHallPressed");
                while (!EUSART1_DataReady);
                (void) EUSART1_Read();  // Clear Flag
                
                /* Get converted Hall pressed value */
                ADC_StartConversion();
                while(!ADC_IsConversionDone());
                nominalHallPressed = ADC_GetConversionResult()>>8;
                
                printf("New nominalHallPressed value = %d\r\n",nominalHallPressed);
                break;                 
                
			//--------------------------------------------
            // Tune noise immunity
			//--------------------------------------------                
            case 'd':
            case 'D':
                if (cmd == 'd') 
                    delta--;
                else 
                    delta++;
                
                printf("delta set to %d\r\n",delta);
                break;
             
            //--------------------------------------------
			// Wait for a keypress and then record samples
			//--------------------------------------------
            case't': 
                printf("Tap a piano key.\r\n");
                velocity = collect(true);
                printf("Strike Velocity = %3u", velocity);
                break;   
            
            //--------------------------------------------
			// Strike indicator and time
			//--------------------------------------------
            case 'T':
                printf("Tap piano key and press keyboard key to exit.\r\n");
                
                while (!EUSART1_DataReady) {// Do until a user presses a key to exit
                    velocity = collect(false);
                    printf("Strike Velocity = %3u", velocity);
                    
                    while(keyState != UNPRESSED);
                    printf("\t\treleased\r\n"); //Print released when state changes to unpressed
                   
                }
                
                (void) EUSART1_Read();  // Clear Flag
                    
                break;
                
            //--------------------------------------------
			// Print out all samples
			//--------------------------------------------
            case 'i':
                printf("Printing %u samples\r\n", N);
                for (i = 0; i < N; i++){
                    printf("%d: %d \r\n",i, hallSamples[i]);
                }
                break;
                    
            //--------------------------------------------
			// Midi mode
			//--------------------------------------------
            case 'M':
                printf("Launch hairless-midiserial\r\n");
                printf("In the hairless-midiserial program:\r\n");
                printf("    File -> preferences\r\n");
                printf("    Baud Rate:  9600\r\n");
                printf("    Data Bits:  8\r\n");
                printf("    Parity:     None\r\n");
                printf("    Stop Bit(s):    1\r\n");
                printf("    Flow Control:   None\r\n");
                printf("    Click ""OK""\r\n");
                printf("    Serial Port -> (Not Connected)\r\n");
                printf("    MIDI Out -> (Not Connected)\r\n\n");
                printf("When you have complete this:\r\n");
                printf("    Close out of Putty.\r\n");                
                printf("    In the hairless-midiserial program:\r\n");
                printf("        Serial Port -> USB Serial Port (COMx)\r\n");
                printf("        MIDI Out -> Microsoft GS Wavetable Synth \r\n");                
                printf("    Press upper push button on Dev'18 to start MIDI play sequence\r\n");                
                printf("    Press lower push button on Dev'18 to exit MIDI play sequence\r\n");
                printf("    In the hairless-midiserial program:\r\n");
                printf("        Serial Port -> (Not Connected)\r\n");
                printf("        MIDI Out -> (Not Connected)\r\n");
                printf("        close hairless\r\n");
                printf("    Launch PuTTY and reconnect to the VCOM port\r\n");
                
                while(TOP_BUTTON_GetValue() == 1);  //Wait until top button is pressed
                putByteSCI(PLAYINSTRUMENT); // Put instrument start instruction
                putByteSCI(instrument); // Put instrument instruction
                
                while(BOTTOM_BUTTON_GetValue() != 0) {  //Do while bottom button is not pressed
                    velocity = collect(false);
                    noteOn(PLAYNOTE, song[songIndex],velocity);
                    while (keyState != UNPRESSED);
                    noteOn(NOTEDONE, song[songIndex], velocity);
                    
                    songIndex++;
                    if (songIndex == NUM_NOTES)
                        songIndex = 0;
                }
//                while(TOP_BUTTON_GetValue() == 1);
//                    putByteSCI(PLAYINSTRUMENT);
//                    putByteSCI(instrument);
//                
//                while(BOTTOM_BUTTON_GetValue() != 0) {
//                    
//                    while (keyState != PRESSED_WAIT);
//                    if(PRESSED_WAIT){
//                        
//                        //calculate velocity
//                        for (i=0; i <64; i++){
//                            if(samples[i] <= nominalHallPressed){
//                                velocity = 128 - i;
//                                break;
//                            }
//                            else if (i == 63){
//                                velocity = 128 - (64 + (samples[i] - nominalHallPressed));
//                            }
//                        }
//                        noteOn(PLAYNOTE, song[songIndex],velocity);
//                        while (keyState != UNPRESSED);
//                        noteOn(NOTEDONE, song[songIndex], velocity);
//                        songIndex++;
//                        if (songIndex >= 30){
//                            songIndex = 0;
//                        }
//                    }          
//                } // end until lower button press
                break;                               
                
			//--------------------------------------------
			// If something unknown is hit, tell user
			//--------------------------------------------
			default:
				printf("Unknown key %c\r\n",cmd);
				break;
			} // end switch
            
		}	// end if
    } // end infinite loop    
} // end main



//*****************************************************************
// Sends a byte to MIDI attached to serial port
//*****************************************************************
void putByteSCI(uint8_t writeByte) {  
        while (PIR1bits.TX1IF == 0);
        PIR1bits.TX1IF = 0;
        TX1REG = writeByte; // send character
} // end putStringSCI 


//Sends the MIDI command over the UART
void noteOn(uint8_t cmd, uint8_t pitch, uint8_t velocity) {
  putByteSCI(cmd);              //First byte "STATUS" byte
  putByteSCI(pitch);            //Second byte note to be played
  putByteSCI(velocity);         //Third byte the 'loudness' of the note (0 turns note off)
}

void myTMR0ISR(void){
    static int numCollected;
    
    uint8_t result = (ADC_GetConversionResult()>>8);
    ADC_StartConversion();
    
    switch(keyState) {
        case UNPRESSED:
            numCollected = 0;
            if(result < nominalHallUnPressed - delta)
                keyState = PRESSED_ACQUIRE;
            break;
        case PRESSED_ACQUIRE:
            hallSamples[numCollected] = result;
            numCollected++;
            if(numCollected == N)
                keyState = PRESSED_WAIT;
            break;
        case PRESSED_WAIT:
            if(result > nominalHallUnPressed - delta)
                keyState = UNPRESSED;
            break;
    }
    
}

uint8_t collect(uint8_t doPrint) {
    while (keyState == UNPRESSED);
    while (keyState != PRESSED_WAIT);

    /* Print all samples */
    uint8_t i;
    uint8_t velocity;
    
    for(i = 0; i < N; i++) {
        if(doPrint)
            printf("%4u", hallSamples[i]);
        
        if(hallSamples[i] <= nominalHallPressed){
            velocity = 2*N - i;
            break;
        }
        else if (i == N-1){
            velocity = 2*N - (N + (hallSamples[i] - nominalHallPressed));
        }

    }

    /* Calculate Velocity */
//    i=0;
//    while( (i < N) && (hallSamples[i] > nominalHallPressed + delta) ) i++;   // Get index of first sample below line
//    if(i == N)  // If no index below line
//        i += hallSamples[i-1] - (nominalHallPressed + delta);

    return velocity;
}

void printMenu(void) {
    printf("-------------------------------------------------\r\n");   
    printf("    Nominal %u to %u\r\n",nominalHallUnPressed,  nominalHallPressed);
    printf("    delta = %d\r\n",delta);
    printf("    sampleRate = %d TMR0 counts = %duS\r\n",sampleRate,sampleRate);
    printf("-------------------------------------------------\r\n");
    printf("?: help menu\r\n");
    printf("o: k\r\n");
    printf("Z: Reset processor.\r\n");
    printf("z: Clear the terminal.\r\n");
    printf("d/D: decrement/increment delta\r\n");
    printf("c/C: calibrate unpressed/pressed hall sensor.\r\n");   
    printf("t: wait for piano keypress and report %d samples, one every %dus.\r\n",N, sampleRate);
    printf("T: strike indicator and time\r\n");
    printf("i: ISR values\r\n");
    printf("M: enter into Midi mode.\r\n");
    printf("-------------------------------------------------\r\n");
}


/**
 End of File
*/