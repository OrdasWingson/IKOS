	.file	"interrupts.c"
	.text
	.comm	irq_base, 1, 0
	.comm	irq_count, 1, 0
	.globl	idt
	.data
	.align 8
idt:
	.quad	4294950912
	.text
	.globl	init_interrupts
	.def	init_interrupts;	.scl	2;	.type	32;	.endef
	.seh_proc	init_interrupts
init_interrupts:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	$4294963184, %eax
	movq	$32771, (%rax)
	movq	idt(%rip), %rax
	movl	$2048, %r8d
	movl	$0, %edx
	movq	%rax, %rcx
	call	memset
	movw	$2048, -10(%rbp)
	movq	idt(%rip), %rax
	movq	%rax, -8(%rbp)
	leaq	-10(%rbp), %rax
/APP
 # 26 "interrupts.c" 1
	lidt (,%rax,)
 # 0 "" 2
/NO_APP
	leaq	irq_base(%rip), %rax
	movb	$32, (%rax)
	leaq	irq_count(%rip), %rax
	movb	$16, (%rax)
	movl	$17, %eax
	movl	$32, %edx
/APP
 # 29 "interrupts.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	leaq	irq_base(%rip), %rax
	movzbl	(%rax), %eax
	movl	$33, %edx
/APP
 # 30 "interrupts.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	movl	$4, %eax
	movl	$33, %edx
/APP
 # 31 "interrupts.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	movl	$1, %eax
	movl	$33, %edx
/APP
 # 32 "interrupts.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	movl	$17, %eax
	movl	$160, %edx
/APP
 # 33 "interrupts.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	leaq	irq_base(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addl	$8, %eax
	movl	$161, %edx
/APP
 # 34 "interrupts.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	movl	$2, %eax
	movl	$161, %edx
/APP
 # 35 "interrupts.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	movl	$1, %eax
	movl	$161, %edx
/APP
 # 36 "interrupts.c" 1
	outb %al, %dx
 # 0 "" 2
 # 38 "interrupts.c" 1
	sti
 # 0 "" 2
/NO_APP
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	set_int_handler
	.def	set_int_handler;	.scl	2;	.type	32;	.endef
	.seh_proc	set_int_handler
set_int_handler:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	%ecx, %eax
	movq	%rdx, 24(%rbp)
	movl	%r8d, %edx
	movb	%al, 16(%rbp)
	movl	%edx, %eax
	movb	%al, 32(%rbp)
/APP
 # 42 "interrupts.c" 1
	pushf 
 cli
 # 0 "" 2
/NO_APP
	movq	idt(%rip), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	addq	%rdx, %rax
	movw	$8, 2(%rax)
	movq	24(%rbp), %rdx
	movq	idt(%rip), %rcx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	addq	%rcx, %rax
	movw	%dx, (%rax)
	movq	24(%rbp), %rax
	shrq	$16, %rax
	movq	%rax, %rdx
	movq	idt(%rip), %rcx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	addq	%rcx, %rax
	movw	%dx, 6(%rax)
	movq	idt(%rip), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	addq	%rax, %rdx
	movzbl	32(%rbp), %eax
	movb	%al, 5(%rdx)
	movq	idt(%rip), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	addq	%rdx, %rax
	movb	$0, 4(%rax)
/APP
 # 48 "interrupts.c" 1
	popf
 # 0 "" 2
/NO_APP
	nop
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	memset;	.scl	2;	.type	32;	.endef
