;GDT
beginGDT:
    nullDesc:
        dq 0
    codeDesc:
        dw 0xffff ; First 16 bits of the limit
        dw 0 ; Base(Low)
        db 0 ; Base(Medium)

        db 0b11001111 ; Flag
        db 0b11001111 ; Flag and Upper Limit
        db 0 ;last 8 bits of the base, Base (High)
    dataDesc:
        ;doing the same thing as the code descriptor
        dw 0xffff
        dw 0
        db 0
        db 0b11001111
        db 0b11001111
        db 0
endGDT:

GDTDesc:
    ;2 entries
    dw endGDT - beginGDT - 1 ;size
    dd beginGDT ;start
    ; 0x08
codeSegment equ codeDesc - beginGDT
dataSegment equ dataDesc - beginGDT