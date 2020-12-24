set o_var=F:\OS\dd-0.5\bin\o\
set c_var=F:\OS\dd-0.5\bin\c\
set bin_var=F:\OS\dd-0.5\bin\
cd f:
cd dd-0.5
F:\OS\fasmw17321\fasm %bin_var%startup.asm  %o_var%startup.o
gcc -c -m32 -ffreestanding -o %o_var%stdlib.o %c_var%stdlib.c
gcc -c -m32 -ffreestanding -o %o_var%main.o %c_var%main.c
gcc -c -m32 -ffreestanding -o %o_var%tty.o %c_var%tty.c
ld -mi386pe -T %bin_var%script.ld -o %bin_var%kernel.bin %o_var%startup.o %o_var%stdlib.o %o_var%main.o 
objcopy  %bin_var%kernel.bin -O binary


