#include "kernel.h"

void kernel_main(void){

    char* video_memory = (char*) 0xb8000;
    *video_memory = 'E';

    for(;;);
    
    return;
}