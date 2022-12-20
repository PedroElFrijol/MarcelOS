section .text 
    [bits 32]
    [global _start]
    [extern kernel_main]

    _start:
        call kernel_main

        cli ;stop interrupts
        jmp $