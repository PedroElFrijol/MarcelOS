CC = clang
NASM = nasm
CFLAGS = -ffreestanding -m32 -g -c -Wall -target i686-unknown-none
LLD = ld.lld
 
SRCDIR = src
OBJDIR = bin
 
all: bootloader run
 
bootloader: 
	$(NASM) $(SRCDIR)/bootloader.asm -Isrc/ -f bin -o $(OBJDIR)/boot.bin
	$(NASM) $(SRCDIR)/kernelEntry.asm -f elf32 -o $(OBJDIR)/kernelEntry.o
	$(CC) $(CFLAGS) $(SRCDIR)/kernel.c -o $(OBJDIR)/kernel.o	

	$(LLD) -O2 -nostdlib -Ttext 0x0 --oformat binary $(OBJDIR)/*.o -o $(OBJDIR)/kernel.bin -L $(OBJDIR)/linker.ld
 
	cat $(OBJDIR)/boot.bin $(OBJDIR)/kernel.bin> $(OBJDIR)/x86.bin
	
run:
	qemu-system-i386 -drive format=raw,file="bin/x86.bin",index=0,if=floppy, -m 128M

#export DISPLAY=:0