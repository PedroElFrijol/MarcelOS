#include "kernel.h"

void _start(void){

    char* video_memory = (char*) 0xb8000;
    *video_memory = 'E';

    for(;;);
    
    return;
}