#include "kernel.h"
#define WHITE 0x07 //black background with white text

unsigned int i = 0;

void ClearScreen(){
    while(i < (80*25*2)){ //80 by 25 characters, each character takes up 2 bytes (80 * 25) is the text mode on x86 machines)
    //Since we access video memory one byte at a time we will need to multiply it by 2 so that each character takes up 2 bytes
    //Loop adds 1 to "i" so we can get to the next byte of video memory then place 0x07 in that spot
        video_memory[i] = ' ';
        i++;
        video_memory[i] = WHITE;
        i++;
    }
};

unsigned int Print(char* str, unsigned int pixels){
    i = (pixels * 80 * 2);
    return 0;
};

int __attribute__((section("__start"))) main(){ //__attribute__((section("main,__start"))) if you are using macos(Mach-O)
    ClearScreen();
    Print("Welcome to MarcelOS!", 0); //0 is the first line of video memory

    // Test to see if it works
    *video_memory = 'e';

    while(1);
};