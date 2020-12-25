LDFLAGS = -mi386pe
CFLAGS = -m32 -ffreestanding


all: script.ld startup.o stdlib.o main.o interrupts.o tty.o
	ld $(LDFLAGS) -T script.ld -o kernel.bin startup.o stdlib.o main.o interrupts.o tty.o
	objcopy kernel.bin -O binary
startup.o: startup.asm
	F:\OS\fasmw17321\fasm startup.asm startup.o
stdlib.o: stdlib.c stdlib.h
	gcc -c $(CFLAGS) -o stdlib.o stdlib.c
interrupts.o: interrupts.c interrupts.h stdlib.h
	gcc -c $(CFLAGS) -o interrupts.o interrupts.c
tty.o: tty.c tty.h stdlib.h
	gcc -c $(CFLAGS) -o tty.o tty.c
main.o: main.c stdlib.h 
	gcc -c $(CFLAGS) -o main.o main.c




	 






	
	
	
	
