LDFLAGS = -mi386pe
CFLAGS = -m32 -ffreestanding


all: script.ld startup.o listFS_asm.o  stdlib.o main.o memory_manager.o interrupts.o tty.o listFS.o
	ld $(LDFLAGS) -T script.ld -o kernel.bin startup.o listFS_asm.o stdlib.o main.o  memory_manager.o interrupts.o tty.o  listFS.o
	objcopy kernel.bin -O binary
startup.o: startup.asm
	C:\Users\Иван\Desktop\ХОББИ\Ассемблер\OS\fasmw17321\fasm startup.asm startup.o
listFS_asm.o: listFS_asm.asm
	C:\Users\Иван\Desktop\ХОББИ\Ассемблер\OS\fasmw17321\FASM listFS_asm.asm listFS_asm.o
stdlib.o: stdlib.c stdlib.h
	gcc -c $(CFLAGS) -o stdlib.o stdlib.c
interrupts.o: interrupts.c interrupts.h stdlib.h
	gcc -c $(CFLAGS) -o interrupts.o interrupts.c
tty.o: tty.c tty.h stdlib.h scancodes.h
	gcc -c $(CFLAGS) -o tty.o tty.c
memory_manager.o: memory_manager.c memory_manager.h stdlib.h
	gcc -c $(CFLAGS) -o memory_manager.o memory_manager.c
listFS.o: listFS_asm.o listFS.c listFS.h 
	gcc -c $(CFLAGS) -o listFS.o listFS.c 
main.o: main.c stdlib.h 
	gcc -c $(CFLAGS) -o main.o main.c




	 






	
	
	
	
