[bits 16]
[org 0x7c00] ;sets the offset to which all absolute addresses will be relative to
;equals to "mov ds, 0x7c0" in real mode

;al and ah are 8 bit char size registers, al = high 8 bits and ah low 8 bits
;ah = bios scand code and al = ascii character (when int 0x16)

kernelLocation equ 0x7c00 + 0x200

;reading from disk  
mov [BOOT_DISK], dl  

;segment registers  
xor ax, ax                          
mov es, ax
mov ds, ax
mov bp, 0x7c00
mov sp, bp

mov bx, 0x7e00

mov ah, 2
mov al, 1 ;number of sectors we want to read which is 1
mov ch, 0 ;cylinder number which is 0
mov dh, 0 ;head number which equals 0
mov cl, 2 ;the sector number which equals 2
mov dl, [BOOT_DISK] ;drive number we saved in the variable
int 0x13 ;or 13h for disk access

mov ah, 0x0e
mov al, [0x7e00]
int 0x10

codeSegment equ codeDesc - beginGDT
dataSegment equ dataDesc - beginGDT

cli ;disable all interrupts
lgdt [GDTDesc] ;load gdt
mov eax, cr0
or eax, 1 ;perform bitwise or operation with one that changes the last bit of eax to 1
mov cr0, eax ;move eax to cr0 and now the cpu is in 32 bit protected mode
jmp codeSegment:beginProtectedMode

BOOT_DISK: db 0

%include "gdt.asm"

[bits 32]
beginProtectedMode:
    mov  ESP, 0x105000  ; Set the stack pointer

    jmp kernelLocation

times 510-($-$$) db 0
dw 0xaa55 ;define word (2 bytes)

;push 6
;pop ax == mov ax, 6