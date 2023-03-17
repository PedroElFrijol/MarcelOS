#pragma once

void ClearScreen();
void Coordinates(int x, int y);

unsigned int Print(char* str, unsigned int pixels);
char* video_memory = (char*) 0xb8000; //start of video memory in protected mode