LDFLAGS = -mi386pe
CFLAGS = -m32 -ffreestanding


all: startup.o stdlib.o tty.o main.o script.ld
	ld $(LDFLAGS) -T script.ld -o kernel.bin startup.o stdlib.o tty.o main.o
	objcopy kernel.bin -O binary
startup.o: startup.asm
	F:\OS\fasmw17321\fasm startup.asm startup.o
stdlib.o: stdlib.c stdlib.h
	gcc -c $(CFLAGS) -o stdlib.o stdlib.c
tty.o: tty.c tty.h stdlib.h
	gcc -c $(CFLAGS) -o tty.o tty.c
main.o: main.c stdlib.h 
	gcc -c $(CFLAGS) -o main.o main.c




	 






	
	
	
	
