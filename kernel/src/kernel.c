#include "kernel.h"

void kernel_main(void) {
    *(char*)0xb8000 = 'E';
    return;
}