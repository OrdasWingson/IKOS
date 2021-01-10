	.file	"tty.c"
	.text
	.comm	irq_base, 1, 0
	.comm	irq_count, 1, 0
	.globl	scancodes
	.data
	.align 32
scancodes:
	.byte	0
	.byte	0
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	48
	.byte	45
	.byte	61
	.byte	8
	.byte	9
	.byte	113
	.byte	119
	.byte	101
	.byte	114
	.byte	116
	.byte	121
	.byte	117
	.byte	105
	.byte	111
	.byte	112
	.byte	91
	.byte	93
	.byte	10
	.byte	0
	.byte	97
	.byte	115
	.byte	100
	.byte	102
	.byte	103
	.byte	104
	.byte	106
	.byte	107
	.byte	108
	.byte	59
	.byte	39
	.byte	96
	.byte	0
	.byte	92
	.byte	122
	.byte	120
	.byte	99
	.byte	118
	.byte	98
	.byte	110
	.byte	109
	.byte	44
	.byte	46
	.byte	47
	.byte	0
	.byte	42
	.byte	0
	.byte	32
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	45
	.byte	0
	.byte	0
	.byte	0
	.byte	43
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.globl	scancodes_shifted
	.align 32
scancodes_shifted:
	.byte	0
	.byte	0
	.byte	33
	.byte	64
	.byte	35
	.byte	36
	.byte	37
	.byte	94
	.byte	38
	.byte	42
	.byte	40
	.byte	41
	.byte	95
	.byte	43
	.byte	8
	.byte	9
	.byte	81
	.byte	87
	.byte	69
	.byte	82
	.byte	84
	.byte	89
	.byte	85
	.byte	73
	.byte	79
	.byte	80
	.byte	123
	.byte	125
	.byte	10
	.byte	0
	.byte	65
	.byte	83
	.byte	68
	.byte	70
	.byte	71
	.byte	72
	.byte	74
	.byte	75
	.byte	76
	.byte	58
	.byte	34
	.byte	126
	.byte	0
	.byte	124
	.byte	90
	.byte	88
	.byte	67
	.byte	86
	.byte	66
	.byte	78
	.byte	77
	.byte	60
	.byte	62
	.byte	63
	.byte	0
	.byte	42
	.byte	0
	.byte	32
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	45
	.byte	0
	.byte	0
	.byte	0
	.byte	43
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.comm	tty_width, 4, 2
	.comm	tty_height, 4, 2
	.comm	cursor, 4, 2
	.comm	text_attr, 1, 0
	.comm	tty_buffer, 8, 3
	.comm	tty_io_port, 2, 1
	.globl	digits
	.section .rdata,"dr"
	.align 16
digits:
	.ascii "0123456789ABCDEF\0"
	.comm	num_buffer, 65, 5
	.comm	key_buffer, 16, 4
	.globl	key_buffer_head
	.bss
	.align 4
key_buffer_head:
	.space 4
	.globl	key_buffer_tail
	.align 4
key_buffer_tail:
	.space 4
	.text
	.globl	init_tty
	.def	init_tty;	.scl	2;	.type	32;	.endef
	.seh_proc	init_tty
init_tty:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
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
	leaq	irq_base(%rip), %rax
	movzbl	(%rax), %eax
	addl	$1, %eax
	movzbl	%al, %eax
	movl	$142, %r8d
	movq	.refptr.keyboard_int_handler(%rip), %rdx
	movl	%eax, %ecx
	call	set_int_handler
	nop
	addq	$32, %rsp
	popq	%rbp
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
	testl	%eax, %eax
	je	.L3
	cmpl	$10, %eax
	jne	.L4
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
	jmp	.L5
.L3:
	leaq	cursor(%rip), %rax
	movl	(%rax), %eax
	leal	-1(%rax), %edx
	leaq	cursor(%rip), %rax
	movl	%edx, (%rax)
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
	movl	%eax, %ecx
	call	move_cursor
	jmp	.L5
.L4:
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
.L5:
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
	jmp	.L7
.L8:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %ecx
	call	out_char
	addq	$1, 16(%rbp)
.L7:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L8
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
	ja	.L12
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
.L12:
	leaq	tty_io_port(%rip), %rax
	movzwl	(%rax), %edx
	movl	$14, %eax
/APP
 # 89 "tty.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	leaq	cursor(%rip), %rax
	movl	(%rax), %eax
	shrl	$8, %eax
	movl	%eax, %ecx
	leaq	tty_io_port(%rip), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	leal	1(%rax), %edx
	movl	%ecx, %eax
/APP
 # 90 "tty.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	leaq	tty_io_port(%rip), %rax
	movzwl	(%rax), %edx
	movl	$15, %eax
/APP
 # 91 "tty.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	leaq	cursor(%rip), %rax
	movl	(%rax), %eax
	movzbl	%al, %eax
	leaq	tty_io_port(%rip), %rdx
	movzwl	(%rdx), %edx
	movzwl	%dx, %edx
	addl	$1, %edx
/APP
 # 92 "tty.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	int_to_str
	.def	int_to_str;	.scl	2;	.type	32;	.endef
	.seh_proc	int_to_str
int_to_str:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movl	%edx, %eax
	movb	%al, 24(%rbp)
	movq	$64, -8(%rbp)
	movq	-8(%rbp), %rax
	leaq	-1(%rax), %rdx
	movq	%rdx, -8(%rbp)
	leaq	num_buffer(%rip), %rdx
	movb	$0, (%rdx,%rax)
.L14:
	movzbl	24(%rbp), %ecx
	movq	16(%rbp), %rax
	movl	$0, %edx
	divq	%rcx
	movq	%rdx, %rcx
	movq	-8(%rbp), %rax
	leaq	-1(%rax), %rdx
	movq	%rdx, -8(%rbp)
	leaq	digits(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	leaq	num_buffer(%rip), %rcx
	movb	%dl, (%rcx,%rax)
	movzbl	24(%rbp), %ecx
	movq	16(%rbp), %rax
	movl	$0, %edx
	divq	%rcx
	movq	%rax, 16(%rbp)
	cmpq	$0, 16(%rbp)
	jne	.L14
	movq	-8(%rbp), %rax
	leaq	1(%rax), %rdx
	leaq	num_buffer(%rip), %rax
	addq	%rdx, %rax
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	printf
	.def	printf;	.scl	2;	.type	32;	.endef
	.seh_proc	printf
printf:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movq	%r8, 32(%rbp)
	movq	%r9, 40(%rbp)
	leaq	24(%rbp), %rax
	movq	%rax, -16(%rbp)
	jmp	.L17
.L29:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$37, %al
	jne	.L18
	addq	$1, 16(%rbp)
	movq	-16(%rbp), %rax
	leaq	8(%rax), %rdx
	movq	%rdx, -16(%rbp)
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	cmpl	$100, %eax
	je	.L19
	cmpl	$100, %eax
	jg	.L20
	cmpl	$98, %eax
	je	.L21
	cmpl	$98, %eax
	jg	.L22
	cmpl	$37, %eax
	je	.L23
	jmp	.L28
.L20:
	cmpl	$115, %eax
	je	.L25
	cmpl	$120, %eax
	je	.L26
	cmpl	$111, %eax
	je	.L27
	jmp	.L28
.L23:
	movl	$37, %ecx
	call	out_char
	jmp	.L28
.L22:
	movq	-8(%rbp), %rax
	movsbl	%al, %eax
	movl	%eax, %ecx
	call	out_char
	jmp	.L28
.L25:
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	out_string
	jmp	.L28
.L21:
	movq	-8(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	int_to_str
	movq	%rax, %rcx
	call	out_string
	jmp	.L28
.L27:
	movq	-8(%rbp), %rax
	movl	$8, %edx
	movq	%rax, %rcx
	call	int_to_str
	movq	%rax, %rcx
	call	out_string
	jmp	.L28
.L19:
	movq	-8(%rbp), %rax
	movl	$10, %edx
	movq	%rax, %rcx
	call	int_to_str
	movq	%rax, %rcx
	call	out_string
	jmp	.L28
.L26:
	movq	-8(%rbp), %rax
	movl	$16, %edx
	movq	%rax, %rcx
	call	int_to_str
	movq	%rax, %rcx
	call	out_string
	nop
	jmp	.L28
.L18:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %ecx
	call	out_char
.L28:
	addq	$1, 16(%rbp)
.L17:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L29
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	in_scancode
	.def	in_scancode;	.scl	2;	.type	32;	.endef
	.seh_proc	in_scancode
in_scancode:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movl	key_buffer_head(%rip), %edx
	movl	key_buffer_tail(%rip), %eax
	cmpl	%eax, %edx
	je	.L31
	movl	key_buffer_head(%rip), %eax
	cmpl	$15, %eax
	jbe	.L32
	movl	$0, key_buffer_head(%rip)
.L32:
	movl	key_buffer_head(%rip), %edx
	leaq	key_buffer(%rip), %rax
	movl	%edx, %edx
	movzbl	(%rax,%rdx), %eax
	movb	%al, -1(%rbp)
	movl	key_buffer_head(%rip), %eax
	addl	$1, %eax
	movl	%eax, key_buffer_head(%rip)
	jmp	.L33
.L31:
	movb	$0, -1(%rbp)
.L33:
	movzbl	-1(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	in_char
	.def	in_char;	.scl	2;	.type	32;	.endef
	.seh_proc	in_char
in_char:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	%ecx, 16(%rbp)
.L44:
	call	in_scancode
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	cmpl	$54, %eax
	je	.L36
	cmpl	$54, %eax
	jg	.L37
	cmpl	$42, %eax
	je	.L36
	jmp	.L38
.L37:
	cmpl	$170, %eax
	je	.L39
	cmpl	$182, %eax
	je	.L39
	jmp	.L38
.L36:
	movl	$1, shift.2122(%rip)
	jmp	.L38
.L39:
	movl	$0, shift.2122(%rip)
	nop
.L38:
	movzbl	-1(%rbp), %eax
	testb	%al, %al
	jns	.L40
	movb	$0, -1(%rbp)
.L40:
	movl	shift.2122(%rip), %eax
	testl	%eax, %eax
	je	.L41
	movzbl	-1(%rbp), %eax
	cltq
	leaq	scancodes_shifted(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movb	%al, -1(%rbp)
	jmp	.L42
.L41:
	movzbl	-1(%rbp), %eax
	cltq
	leaq	scancodes(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movb	%al, -1(%rbp)
.L42:
	cmpl	$0, 16(%rbp)
	je	.L43
	cmpb	$0, -1(%rbp)
	je	.L44
.L43:
	movzbl	-1(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	in_string
	.def	in_string;	.scl	2;	.type	32;	.endef
	.seh_proc	in_string
in_string:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movq	$0, -8(%rbp)
.L52:
	movl	$1, %ecx
	call	in_char
	movb	%al, -9(%rbp)
	movsbl	-9(%rbp), %eax
	cmpl	$8, %eax
	je	.L47
	cmpl	$10, %eax
	je	.L48
	testl	%eax, %eax
	jne	.L49
	jmp	.L50
.L47:
	cmpq	$0, -8(%rbp)
	je	.L53
	subq	$1, -8(%rbp)
	movl	$0, %ecx
	call	out_char
	jmp	.L53
.L48:
	movl	$10, %ecx
	call	out_char
	jmp	.L50
.L49:
	movq	24(%rbp), %rax
	subq	$1, %rax
	cmpq	%rax, -8(%rbp)
	jnb	.L50
	movq	16(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-9(%rbp), %eax
	movb	%al, (%rdx)
	addq	$1, -8(%rbp)
	movsbl	-9(%rbp), %eax
	movl	%eax, %ecx
	call	out_char
	jmp	.L50
.L53:
	nop
.L50:
	cmpb	$10, -9(%rbp)
	jne	.L52
	movq	16(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
/APP
	_keyboard_int_handler:
 pusha 
 call __keyboard_int_handler 
 movb $0x20, %al 
 outb %al, $0x20 
 outb %al, $0xA0 
 popa 
 iret
/NO_APP
	.globl	_keyboard_int_handler
	.def	_keyboard_int_handler;	.scl	2;	.type	32;	.endef
	.seh_proc	_keyboard_int_handler
_keyboard_int_handler:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movl	$96, %eax
	movl	%eax, %edx
/APP
 # 216 "tty.c" 1
	inb %dx, %al
 # 0 "" 2
/NO_APP
	movb	%al, -1(%rbp)
	movl	key_buffer_tail(%rip), %eax
	cmpl	$15, %eax
	jbe	.L55
	movl	$0, key_buffer_tail(%rip)
.L55:
	movl	key_buffer_tail(%rip), %eax
	addl	$1, %eax
	movl	%eax, key_buffer_tail(%rip)
	movl	key_buffer_tail(%rip), %eax
	leal	-1(%rax), %ecx
	movzbl	-1(%rbp), %eax
	leaq	key_buffer(%rip), %rdx
	movl	%ecx, %ecx
	movb	%al, (%rdx,%rcx)
	movl	$97, %eax
	movl	%eax, %edx
/APP
 # 225 "tty.c" 1
	inb %dx, %al
 # 0 "" 2
/NO_APP
	movb	%al, -2(%rbp)
	orb	$1, -2(%rbp)
	movzbl	-2(%rbp), %eax
	movl	$97, %edx
/APP
 # 227 "tty.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	nop
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
.lcomm shift.2122,4,4
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	set_int_handler;	.scl	2;	.type	32;	.endef
	.def	memset_word;	.scl	2;	.type	32;	.endef
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr.keyboard_int_handler, "dr"
	.globl	.refptr.keyboard_int_handler
	.linkonce	discard
.refptr.keyboard_int_handler:
	.quad	keyboard_int_handler
