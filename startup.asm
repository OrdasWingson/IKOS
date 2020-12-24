format ELF

public _start
extrn  _kernel_main

section ".text" executable

_start:
        movzx edx, dl
        push ebx
        push esi
        push edx
        lgdt [gdtr]
        call _kernel_main ;ffc0000d
@@:
        ;cli
        ;hlt
        jmp @b

section ".data" writable

gdt:
        dq 0                 
        dq 0x00CF9A000000FFFF
        dq 0x00CF92000000FFFF
gdtr:
        dw $ - gdt
        dd gdt