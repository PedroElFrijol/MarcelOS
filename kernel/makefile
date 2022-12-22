CC = clang
NASM = nasm
CFLAGS = -masm=intel -O1 -Wno-error -c -nostdinc -nostdlib -fno-builtin -fno-stack-protector -ffreestanding -m32
LD = ld64
 
SRCDIR = src
OBJDIR = bin
 
all: bootloader run
 
bootloader: 
	$(NASM) $(SRCDIR)/bootloader.asm -f bin -o $(OBJDIR)/boot.bin
	$(CC) $(CFLAGS) -c $(SRCDIR)/kernel.c -o $(OBJDIR)/kernel.o	

	$(LD) -m elf_i386 -Tsrc/kernel.ld --oformat binary -o $(OBJDIR)/kernel.out $(OBJDIR)/kernel.o

	cat $(OBJDIR)/boot.bin $(OBJDIR)/kernel.out > $(OBJDIR)/x86.bin
	
run:
	qemu-system-i386 bin/x86.bin

#export DISPLAY=:0