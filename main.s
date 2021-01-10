	.file	"main.c"
	.text
	.comm	irq_base, 1, 0
	.comm	irq_count, 1, 0
	.section .rdata,"dr"
.LC0:
	.ascii "Welcome to IKOS!\12\0"
.LC1:
	.ascii "Boot disk id is %d\12\0"
.LC2:
	.ascii "Memory map at 0x%x\12\0"
.LC3:
	.ascii "Boot module list at 0x%x\12\0"
.LC4:
	.ascii "Enter string: \0"
.LC5:
	.ascii "You typed: %s\12\0"
	.text
	.globl	kernel_main
	.def	kernel_main;	.scl	2;	.type	32;	.endef
	.seh_proc	kernel_main
kernel_main:
	pushq	%rbp
	.seh_pushreg	%rbp
	subq	$288, %rsp
	.seh_stackalloc	288
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movl	%ecx, %eax
	movq	%rdx, 184(%rbp)
	movq	%r8, 192(%rbp)
	movb	%al, 176(%rbp)
	call	init_interrupts
	call	init_tty
	movl	$31, %ecx
	call	set_text_attr
	call	clear_screen
	leaq	.LC0(%rip), %rcx
	call	printf
	movzbl	176(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	184(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	movq	192(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
.L2:
	leaq	.LC4(%rip), %rcx
	call	out_string
	leaq	-96(%rbp), %rax
	movl	$256, %edx
	movq	%rax, %rcx
	call	in_string
	leaq	-96(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC5(%rip), %rcx
	call	printf
	jmp	.L2
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	init_interrupts;	.scl	2;	.type	32;	.endef
	.def	init_tty;	.scl	2;	.type	32;	.endef
	.def	set_text_attr;	.scl	2;	.type	32;	.endef
	.def	clear_screen;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	out_string;	.scl	2;	.type	32;	.endef
	.def	in_string;	.scl	2;	.type	32;	.endef
