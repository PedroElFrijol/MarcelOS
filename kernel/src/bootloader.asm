[bits 16] ;computer starts in Real Mode which is 16 bit
[org 0x7C00] ;tells the compiler where the code will be (origin)

; Set video mode
mov ah, 0x00
mov al, 0x03
int 0x10 ;runs bios video interrupt

; Clear out ds and es 
xor ax, ax ;set ax register to 0                 
mov es, ax ;set ax register to 0     
mov ds, ax ;set data segment to 0

; Setup stack segments
cli ;disable interrupts just to make sure one does not happen while setting up stack segments
mov bp, 0x7c00 ;Holds the base address of the stack
mov sp, bp
mov ss, ax
sti ;enabling interrupts

; Store drive number
mov [BOOT_DISK], dl ;the disk we are trying to read is most likely the disk we booted from (aka "dl")

; Read in sectors
mov ax, kernelLocation
mov es, ax          
xor bx, bx          ; bx=0, bx:es=0x0:0x07E0=0x7E00

mov ah, 2
mov al, 1 ;number of sectors we want to read which is 1
mov ch, 0 ;cylinder number which is 0
mov dh, 0 ;head number which equals 0
mov cl, 2 ;the sector number which equals 2 because we are reading from the second sector of the same head and the same cyilnder
mov dl, [BOOT_DISK] ;drive number we saved in the variable
int 0x13 ;or 13h for disk access
;jc failed

;Enabling the A20 Line
mov al, 0x92
or al, 0x02
out 0x92, al


; Loading GDT
cli
lgdt [GDTDesc]
mov eax, cr0
or eax, 0x01
mov cr0, eax

jmp codeSegment:beginProtectedMode

jmp $

%include "src/gdt.asm"

[bits 32]
beginProtectedMode:
    mov ax, dataSegment
    mov es, ax
    mov ds, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov si, text ;point text to source index
    call print               

    text db 'Welcome to MarcelOS!',0

    print:
        mov ah, 0x0E

    jmp codeSegment:kernelLocation
    jmp codeSegment:kernel_exact

BOOT_DISK db 0
kernelLocation equ 0x07E0 ; segment:offset = 0x0:0x07E0=0x7E00
kernel_exact equ 0x7c00 + 0x200 ; actual address

times 510 - ($ - $$) db 0x0
dw 0xAA55