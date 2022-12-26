set BIN=%0/../bin

qemu-system-x86_64 -drive format=raw,file=%BIN%/x86.bin,if=ide,index=0,media=disk
pause