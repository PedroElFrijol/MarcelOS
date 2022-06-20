#include "kernel.h"

void _start(){
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'E';
    Print(video_memory, "amongus");
    return;
}