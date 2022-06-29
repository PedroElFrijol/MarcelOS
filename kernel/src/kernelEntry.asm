section .text 
    [bits 32]
    [extern kernel_main]

    _start:
        jmp $
        call kernel_main
        jmp $