CC = clang
NASM = nasm
CFLAGS = -masm=intel -O1 -Wno-error -c -nostdinc -nostdlib -fno-builtin -fno-stack-protector -ffreestanding -m32
LD = ld.lld #ld64 for macos		#ld.lld for wsl
 
SRCDIR = src
OBJDIR = bin
 
all: bootloader image run
 
bootloader: 
	$(NASM) $(SRCDIR)/bootloader.asm -f bin -o $(OBJDIR)/boot.bin
	$(CC) $(CFLAGS) -c $(SRCDIR)/kernel.c -o $(OBJDIR)/kernel.o	

	$(LD) -m elf_i386 -Tsrc/kernel.ld --oformat binary -o $(OBJDIR)/kernel.out $(OBJDIR)/kernel.o

	cat $(OBJDIR)/boot.bin $(OBJDIR)/kernel.out > $(OBJDIR)/x86.bin
	
image:
	dd if=$(OBJDIR)/x86.bin of=OS.img

run:
	qemu-system-i386 -drive format=raw,file=bin/x86.bin,if=ide,index=0,media=disk

#export DISPLAY=:0.0