[bits 16] ;computer starts in Real Mode which is 16 bit
[org 0x7c00] ;tells the compiler where the code will be (origin)
;equals to "mov ds, 0x7c0" in real mode

;0x7c00 is the memory address where the BIOS loads Master boot Record (MBR) which is the first sector in the drive

;al and ah are 8 bit char size registers, al = high 8 bits and ah low 8 bits
;ah = bios scand code and al = ascii character (when int 0x16)
;bl register is used to set a page number

kernelLocation equ 0x7c00 + 0x200 ;set the kernel location here, origin + bootsector size()

;reading from disk  
;the disk we are trying to read is most likely the disk we booted from (aka "dl")
mov [BOOT_DISK], dl  

;each section is 512 bytes long

;segment registers  
xor ax, ax ;set ax register to 0                 
mov es, ax ;set extra segmentes to 0
mov ds, ax ;set data segment to 0

cli ;disable interrpts just to make sure one does not happen while setting up stack segments
mov bp, 0x7c00 ;Holds the base address of the stack
mov sp, bp
mov ss, ax
sti; enable interrupts

mov bx, kernelLocation ;this is where we load the sectors (kernel location)
;bx is a pointer to data

mov ah, 2
mov al, 1 ;number of sectors we want to read which is 1
mov ch, 0 ;cylinder number which is 0
mov dh, 0 ;head number which equals 0
mov cl, 2 ;the sector number which equals 2 because we are reading from the second sector of the same head and the same cyilnder
mov dl, [BOOT_DISK] ;drive number we saved in the variable
int 0x13 ;or 13h for disk access

mov ah, 0
mov al, 3
int 0x10 ;runs bios video interrupt

codeSegment equ codeDesc - beginGDT
dataSegment equ dataDesc - beginGDT

cli ;disable all interrupts
lgdt [GDTDesc] ;load gdt
mov eax, cr0
or eax, 1 ;perform bitwise or operation with one that changes the last bit of eax to 1
mov cr0, eax ;move eax to cr0 and now the cpu is in 32 bit protected mode
jmp codeSegment:beginProtectedMode

jmp $

BOOT_DISK: db 0

%include "gdt.asm"

[bits 32]
beginProtectedMode:
    mov si, text ;point text to source index
    call print               

    text db 'Welcome to MarcelOS!',0

    print:
        mov ah, 0x0E

    jmp kernelLocation

times 510-($-$$) db 0
dw 0xaa55 ;define word (2 bytes)