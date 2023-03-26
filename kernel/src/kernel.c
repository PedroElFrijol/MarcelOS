#include "kernel.h"
#define WHITE 0x07 //black background with white text

unsigned int i = 0;
char* video_memory = (char*) 0xb8000; //start of video memory in protected mode

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

unsigned int Print(char* str, Font font, uint8_t* framebuffer, int x, int y, unsigned int color){
    i = 0; // reset i to zero before starting to write to video memory

    while (str[i] != '\0') { // iterate through the string until the null terminator is reached
        // if we've reached the end of a row, move to the start of the next row
        if ((i / 2) % 80 == 0 && i != 0) {
            i += (80 - (i / 2) % 80) * 2; // move to the start of the next row
        }

        // print the current character to the screen
        video_memory[i] = str[i];
        i++;
        video_memory[i] = WHITE;
        i++;
    }
    return 0;
}

Font load_font(const char* font_file){
    return font;
}

int __attribute__((section("__start"))) main(){ //__attribute__((section("main,__start"))) if you are using macos(Mach-O)
    ClearScreen();
    uint8_t* framebuffer = fb_info(0xB8000, 80 * 25 * 2);
    Font font = load_font("bin/Marcellus.bdf");

    Print("Welcome to MarcelOS!", font, framebuffer, 80, 25, 0xFF); //0 is the first line of video memory
    // Test to see if it works
    //*video_memory = 'e';

    while(1);
};