#pragma once

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

typedef struct {
    //font info
} Font;

void ClearScreen();
unsigned int Print(char* str, Font font, uint8_t* framebuffer, int x, int y, unsigned int color);
Font load_font(const char* font_file);
uint8_t* fb_info(uint32_t address, uint32_t size);

extern Font font;
extern uint8_t* framebuffer;