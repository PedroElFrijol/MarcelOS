CC = clang
NASM = nasm
CFLAGS = -ffreestanding -m32 -g -c -Wall -target i686-unknown-none
 
SRCDIR = src
OBJDIR = bin
 
all: bootloader run
 
bootloader: 
	$(NASM) $(SRCDIR)/bootloader.asm -f bin -o $(OBJDIR)/boot.bin
	$(NASM) $(SRCDIR)/kernelEntry.asm -f elf -o $(OBJDIR)/kernelEntry.o
	$(NASM) $(SRCDIR)/zeroes.asm -f bin -o $(OBJDIR)/zeroes.bin
	$(CC) $(CFLAGS) $(SRCDIR)/kernel.c -o $(OBJDIR)/kernel.o	
 
	cat $(OBJDIR)/boot.bin $(OBJDIR)/zeroes.bin > $(OBJDIR)/x86.bin
 
run:
	qemu-system-i386 -drive format=raw,file="bin/x86.bin",index=0,if=floppy, -m 128M