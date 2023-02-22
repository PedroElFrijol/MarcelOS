[bits 16] ;computer starts in Real Mode which is 16 bit
[org 0x7C00] ;tells the compiler where the code will be (origin)
;each interrupt requires certain data to be stored in certain registers.

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
mov es, ax
mov bx, kernelLocation ; segment:offset = es:bx
                       ; formula = (segment * 16) + offset
                       ; es:bx = 0x07E0(kernel_loc):0x0000
                       ; (0x07E0 * 16) + 0x0000 = 0x7E00

mov ah, 2
mov al, 1 ;number of sectors we want to read which is 1
mov ch, 0 ;cylinder number which is 0
mov dh, 0 ;head number which equals 0
mov cl, 2 ;the sector number which equals 2 because we are reading from the second sector of the same head and the same cyilnder
mov dl, [BOOT_DISK] ;drive number we saved in the variable
int 0x13 ;or 13h for disk access

;segment:offset = (segment * 16) + offset

;Enabling the A20 Line, address line 20, is one of the electrical lines that make up the system bus of an x86-based computer system
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

%include "src/gdt.asm"

[bits 32]
beginProtectedMode:
    mov ax, dataSegment
    mov es, ax
    mov ds, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax           

    jmp codeSegment:kernelLocation

BOOT_DISK db 0
kernelLocation equ 0x7c00 + 0x200 ; actual address
text db 'Welcome to MarcelOS!',0

times 510 - ($ - $$) db 0x0
dw 0xAA55