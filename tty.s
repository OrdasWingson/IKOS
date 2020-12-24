	.file	"tty.c"
	.text
	.comm	tty_width, 4, 2
	.comm	tty_height, 4, 2
	.comm	cursor, 4, 2
	.comm	text_attr, 1, 0
	.comm	tty_buffer, 8, 3
	.comm	tty_io_port, 2, 1
	.globl	init_tty
	.def	init_tty;	.scl	2;	.type	32;	.endef
	.seh_proc	init_tty
init_tty:
	.seh_endprologue
	leaq	tty_buffer(%rip), %rax
	movq	$753664, (%rax)
	movl	$1098, %eax
	movzwl	(%rax), %eax
	movzwl	%ax, %edx
	leaq	tty_width(%rip), %rax
	movl	%edx, (%rax)
	leaq	tty_height(%rip), %rax
	movl	$25, (%rax)
	movl	$1123, %eax
	movzwl	(%rax), %edx
	leaq	tty_io_port(%rip), %rax
	movw	%dx, (%rax)
	movl	$1105, %eax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	leaq	tty_width(%rip), %rax
	movl	(%rax), %eax
	imull	%eax, %edx
	movl	$1104, %eax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addl	%eax, %edx
	leaq	cursor(%rip), %rax
	movl	%edx, (%rax)
	leaq	text_attr(%rip), %rax
	movb	$7, (%rax)
	nop
	ret
	.seh_endproc
	.globl	out_char
	.def	out_char;	.scl	2;	.type	32;	.endef
	.seh_proc	out_char
out_char:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %eax
	movb	%al, 16(%rbp)
	movsbl	16(%rbp), %eax
	cmpl	$10, %eax
	jne	.L3
	leaq	cursor(%rip), %rax
	movl	(%rax), %edx
	leaq	tty_width(%rip), %rax
	movl	(%rax), %ecx
	movl	%edx, %eax
	movl	$0, %edx
	divl	%ecx
	leal	1(%rax), %edx
	leaq	tty_width(%rip), %rax
	movl	(%rax), %eax
	imull	%edx, %eax
	movl	%eax, %ecx
	call	move_cursor
	jmp	.L4
.L3:
	leaq	tty_buffer(%rip), %rax
	movq	(%rax), %rdx
	leaq	cursor(%rip), %rax
	movl	(%rax), %eax
	movl	%eax, %eax
	addq	%rax, %rax
	addq	%rax, %rdx
	movzbl	16(%rbp), %eax
	movb	%al, (%rdx)
	leaq	tty_buffer(%rip), %rax
	movq	(%rax), %rdx
	leaq	cursor(%rip), %rax
	movl	(%rax), %eax
	movl	%eax, %eax
	addq	%rax, %rax
	addq	%rax, %rdx
	leaq	text_attr(%rip), %rax
	movzbl	(%rax), %eax
	movb	%al, 1(%rdx)
	leaq	cursor(%rip), %rax
	movl	(%rax), %eax
	addl	$1, %eax
	movl	%eax, %ecx
	call	move_cursor
.L4:
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	out_string
	.def	out_string;	.scl	2;	.type	32;	.endef
	.seh_proc	out_string
out_string:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	jmp	.L6
.L7:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %ecx
	call	out_char
	addq	$1, 16(%rbp)
.L6:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L7
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	clear_screen
	.def	clear_screen;	.scl	2;	.type	32;	.endef
	.seh_proc	clear_screen
clear_screen:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leaq	tty_width(%rip), %rax
	movl	(%rax), %edx
	leaq	tty_height(%rip), %rax
	movl	(%rax), %eax
	imull	%edx, %eax
	movl	%eax, %r8d
	leaq	text_attr(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	addl	$32, %eax
	movzwl	%ax, %eax
	leaq	tty_buffer(%rip), %rdx
	movq	(%rdx), %rcx
	movl	%eax, %edx
	call	memset_word
	movl	$0, %ecx
	call	move_cursor
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	set_text_attr
	.def	set_text_attr;	.scl	2;	.type	32;	.endef
	.seh_proc	set_text_attr
set_text_attr:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	%ecx, %eax
	movb	%al, 16(%rbp)
	movzbl	16(%rbp), %eax
	leaq	text_attr(%rip), %rdx
	movb	%al, (%rdx)
	nop
	popq	%rbp
	ret
	.seh_endproc
	.globl	move_cursor
	.def	move_cursor;	.scl	2;	.type	32;	.endef
	.seh_proc	move_cursor
move_cursor:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	leaq	cursor(%rip), %rax
	movl	16(%rbp), %edx
	movl	%edx, (%rax)
	leaq	tty_width(%rip), %rax
	movl	(%rax), %edx
	leaq	tty_height(%rip), %rax
	movl	(%rax), %eax
	imull	%eax, %edx
	leaq	cursor(%rip), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	ja	.L11
	leaq	tty_height(%rip), %rax
	movl	(%rax), %eax
	leal	-1(%rax), %edx
	leaq	tty_width(%rip), %rax
	movl	(%rax), %eax
	imull	%eax, %edx
	leaq	cursor(%rip), %rax
	movl	%edx, (%rax)
	leaq	tty_width(%rip), %rax
	movl	(%rax), %edx
	leaq	tty_height(%rip), %rax
	movl	(%rax), %eax
	imull	%edx, %eax
	movl	%eax, %eax
	leaq	(%rax,%rax), %rcx
	leaq	tty_buffer(%rip), %rax
	movq	(%rax), %rdx
	leaq	tty_width(%rip), %rax
	movl	(%rax), %eax
	movl	%eax, %eax
	addq	%rax, %rax
	addq	%rax, %rdx
	leaq	tty_buffer(%rip), %rax
	movq	(%rax), %rax
	movq	%rcx, %r8
	movq	%rax, %rcx
	call	memcpy
	leaq	tty_width(%rip), %rax
	movl	(%rax), %eax
	movl	%eax, %r9d
	leaq	text_attr(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	addl	$32, %eax
	movzwl	%ax, %eax
	leaq	tty_buffer(%rip), %rdx
	movq	(%rdx), %rcx
	leaq	tty_height(%rip), %rdx
	movl	(%rdx), %edx
	leal	-1(%rdx), %r8d
	leaq	tty_width(%rip), %rdx
	movl	(%rdx), %edx
	imull	%r8d, %edx
	movl	%edx, %edx
	addq	%rdx, %rdx
	addq	%rdx, %rcx
	movq	%r9, %r8
	movl	%eax, %edx
	call	memset_word
.L11:
	leaq	tty_io_port(%rip), %rax
	movzwl	(%rax), %edx
	leaq	cursor(%rip), %rax
	movl	(%rax), %eax
	movl	%eax, %ecx
/APP
 # 60 "tty.c" 1
	movw %dx, %dx 
 movl %ecx, %ecx 
 movb $0x0E, %al 
 movb %ch, %ah 
 outw %ax, %dx 
 incb %al 
 movb %cl, %ah 
 outw %ax, %dx
 # 0 "" 2
/NO_APP
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	memset_word;	.scl	2;	.type	32;	.endef
	.def	memcpy;	.scl	2;	.type	32;	.endef
