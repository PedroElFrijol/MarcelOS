#include "kernel.h"

void _start(){
    *(char*)0xb8000 = 'E';
    return;
}