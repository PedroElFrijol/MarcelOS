#pragma once
#include <stdint.h>

void ClearScreen();
void Coordinates(int x, int y);

unsigned int Print(char* str, unsigned int pixels);

Font font = load_font("bin/Marcellus.bdf");
uint8_t* framebuffer = map_physical_address(0xB8000, 80 * 25 * 2); //lengths of the screen + video memory

void render_text(char* str, Font font, uint8_t framebuffer, int x, int  y, unsigned int color);