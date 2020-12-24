	.file	"main.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Hello world!\12\0"
	.text
	.globl	kernel_main
	.def	kernel_main;	.scl	2;	.type	32;	.endef
	.seh_proc	kernel_main
kernel_main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	%ecx, %eax
	movq	%rdx, 24(%rbp)
	movq	%r8, 32(%rbp)
	movb	%al, 16(%rbp)
	movq	$753664, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$2000, %r8d
	movl	$3584, %edx
	movq	%rax, %rcx
	call	memset_word
	movb	$72, -10(%rbp)
	movb	$1, -9(%rbp)
	leaq	-10(%rbp), %rax
	movq	-8(%rbp), %rcx
	movl	$2, %r8d
	movq	%rax, %rdx
	call	memcpy
	call	init_tty
	leaq	.LC0(%rip), %rcx
	call	out_string
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	memset_word;	.scl	2;	.type	32;	.endef
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	init_tty;	.scl	2;	.type	32;	.endef
	.def	out_string;	.scl	2;	.type	32;	.endef
