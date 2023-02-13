;GDT
beginGDT:
    nullDesc:
        dq 0
    codeDesc:
        .code_limit        dw 0xffff ; First 16 bits of the limit, 0xFFFFF for full 32-bit range
        .code_base_low     dw 0 ; Base(Low) 0-15 bits
        .code_base_med     db 0 ; Base(Medium) 16-23 bits

        .code_access       db 10011010b  ; access (present, ring 0, code segment, executable, direction 0, readable)
        .code_granularity         db 0b11001111 ; Flag and Upper Limit
        .code_base_high    db 0 ;last 8 bits of the base, Base (High)
    dataDesc:
        ;doing the same thing as the code descriptor
        .data_limit        0xffff
        .data_base_low     dw 0 ; base low 0-15 bits
        .data_base_med     db 0 ; base medium 16 - 23
        .data_access       db 10010010b ; access (present, ring 0, data segment, executable, direction 0, writable)
        .data_granularity         db 0b11001111 ; granularity (4k pages, 32-bit pmode) + limit (bits 16-19)
        .data_base_high    db 0 ; base high
endGDT:

GDTDesc:
    ;2 entries
    dw endGDT - beginGDT - 1 ;size
    dd beginGDT ;start
    ; 0x08
codeSegment equ codeDesc - beginGDT
dataSegment equ dataDesc - beginGDT