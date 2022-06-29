#pragma once

struct Coordinates{
    int X;
    int Y;
};

void Print(char* video_memory, char* str){
    video_memory = (char*) 0xb8000;
    char* chr = (char*)str;
}