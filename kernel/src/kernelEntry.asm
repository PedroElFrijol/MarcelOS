section .text    
    [bits 32]
    [extern kernel_main]

    
    global _start
    _start:
    

        jmp $

        call kernel_main
        jmp $