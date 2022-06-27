#pragma once

struct{
    int X = 0;
    int Y = 0;
} Coordinates;

void Print(char* video_memory, char* str){
    video_memory = (char*) 0xb8000;
    char* chr = (char*)str;
}