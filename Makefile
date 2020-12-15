all:  F:\OS\dd-0.5\bin\main.o  F:\OS\dd-0.5\bin\startup.o  F:\OS\dd-0.5\bin\script.ld
	ld -mi386pe -T  F:\OS\dd-0.5\bin\script.ld -o  F:\OS\dd-0.5\bin\kernel.bin  F:\OS\dd-0.5\bin\main.o  F:\OS\dd-0.5\bin\startup.o
	objcopy  F:\OS\dd-0.5\bin\kernel.bin -O binary
main.o: main.c
	gcc -c -m32 -ffreestanding -o F:\OS\dd-0.5\bin\main.o F:\OS\dd-0.5\bin\main.c
startup.o: startup.i386.asm
	F:\OS\fasmw17321\fasm F:\OS\dd-0.5\bin\startup.i386.asm  F:\OS\dd-0.5\bin\startup.o
clean:
	rm -v *.o F:\OS\dd-0.5\bin\kernel.bin
	
	
	
	
