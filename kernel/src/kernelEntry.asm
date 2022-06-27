section .text    
    [bits 32]
    [extern _start]

    
    global _start
    _start:
        jmp $

        call kernel_main
        jmp $