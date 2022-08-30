section .text 
    [bits 32]
    [global _start]
    [extern kernel_main]

    _start:
        ;jmp $
        call kernel_main

        cli ;stop interrupts
        hlt ;halt cpu
        ;jmp $