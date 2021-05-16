	.file	"main.c"
	.text
	.comm	irq_base, 1, 0
	.comm	irq_count, 1, 0
	.comm	kernel_page_dir, 8, 3
	.comm	memory_size, 8, 3
	.comm	memoryMap, 8, 3
	.comm	addressMemoryMap, 8, 3
	.globl	count_cmnd
	.data
count_cmnd:
	.byte	7
	.globl	commands
	.section .rdata,"dr"
.LC0:
	.ascii "reset\0"
.LC1:
	.ascii "ver\0"
.LC2:
	.ascii "help\0"
.LC3:
	.ascii "smm\0"
.LC4:
	.ascii "env\0"
.LC5:
	.ascii "clear\0"
.LC6:
	.ascii "info\0"
	.data
	.align 32
commands:
	.quad	.LC0
	.quad	.LC1
	.quad	.LC2
	.quad	.LC3
	.quad	.LC4
	.quad	.LC5
	.quad	.LC6
	.section .rdata,"dr"
.LC7:
	.ascii "Welcome to IKOS!\12\0"
.LC8:
	.ascii "kernel_page_dir = 0x%x\12\0"
.LC9:
	.ascii "memory_size = %d MB\12\0"
	.align 8
.LC10:
	.ascii "get_page_info(kernel_page_dir, 0xB8000) = 0x%x\12\0"
.LC11:
	.ascii " 0x%d\12\0"
.LC12:
	.ascii "Boot disk id is %d\12\0"
.LC13:
	.ascii "Memory map at 0x%x\12\0"
.LC14:
	.ascii "Boot module list at 0x%x\12\0"
.LC15:
	.ascii "-> \0"
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
	leaq	addressMemoryMap(%rip), %rax
	movq	184(%rbp), %rdx
	movq	%rdx, (%rax)
	movq	184(%rbp), %rax
	movq	%rax, %rcx
	call	init_memory_manager
	call	init_interrupts
	call	init_tty
	movl	$31, %ecx
	call	set_text_attr
	call	clear_screen
	leaq	memoryMap(%rip), %rax
	movq	184(%rbp), %rdx
	movq	%rdx, (%rax)
	leaq	.LC7(%rip), %rcx
	call	printf
	leaq	kernel_page_dir(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	leaq	memory_size(%rip), %rax
	movq	(%rax), %rax
	shrq	$20, %rax
	movq	%rax, %rdx
	leaq	.LC9(%rip), %rcx
	call	printf
	leaq	kernel_page_dir(%rip), %rax
	movq	(%rax), %rax
	movl	$753664, %edx
	movq	%rax, %rcx
	call	get_page_info
	movq	%rax, %rdx
	leaq	.LC10(%rip), %rcx
	call	printf
	call	get_free_memory_size
	movq	%rax, %rdx
	leaq	.LC11(%rip), %rcx
	call	printf
	movzbl	176(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC12(%rip), %rcx
	call	printf
	leaq	addressMemoryMap(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rdx
	leaq	.LC13(%rip), %rcx
	call	printf
	movq	192(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC14(%rip), %rcx
	call	printf
.L2:
	leaq	.LC15(%rip), %rcx
	call	out_string
	leaq	-96(%rbp), %rax
	movl	$256, %edx
	movq	%rax, %rcx
	call	in_string
	leaq	-96(%rbp), %rax
	movq	%rax, %rcx
	call	commands_handler
	jmp	.L2
	.seh_endproc
	.section .rdata,"dr"
.LC16:
	.ascii "Sorry, this is imposible\12\0"
.LC17:
	.ascii "Version 0.0000001))))\12\0"
.LC18:
	.ascii "Command:\12\0"
.LC19:
	.ascii "%d) %s\12\0"
.LC20:
	.ascii "Command %s not found\12\0"
	.text
	.globl	commands_handler
	.def	commands_handler;	.scl	2;	.type	32;	.endef
	.seh_proc	commands_handler
commands_handler:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movb	$0, -1(%rbp)
	jmp	.L4
.L7:
	movzbl	-1(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	commands(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, %rdx
	movq	16(%rbp), %rcx
	call	strcmp
	testl	%eax, %eax
	je	.L20
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L4:
	movzbl	count_cmnd(%rip), %eax
	cmpb	%al, -1(%rbp)
	jb	.L7
	jmp	.L6
.L20:
	nop
.L6:
	movl	$30, %ecx
	call	set_text_attr
	movzbl	-1(%rbp), %eax
	cmpl	$6, %eax
	ja	.L8
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L10(%rip), %rax
	movl	(%rdx,%rax), %eax
	cltq
	leaq	.L10(%rip), %rdx
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L10:
	.long	.L16-.L10
	.long	.L15-.L10
	.long	.L14-.L10
	.long	.L13-.L10
	.long	.L12-.L10
	.long	.L11-.L10
	.long	.L9-.L10
	.text
.L16:
	leaq	.LC16(%rip), %rcx
	call	printf
	movl	$6, %eax
	movl	$3321, %edx
/APP
 # 82 "main.c" 1
	outb %al, %dx
 # 0 "" 2
/NO_APP
	jmp	.L17
.L15:
	leaq	.LC17(%rip), %rcx
	call	printf
	jmp	.L17
.L14:
	leaq	.LC18(%rip), %rcx
	call	printf
	movl	$0, -8(%rbp)
	jmp	.L18
.L19:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	commands(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movq	%rdx, %r8
	movl	%eax, %edx
	leaq	.LC19(%rip), %rcx
	call	printf
	addl	$1, -8(%rbp)
.L18:
	movzbl	count_cmnd(%rip), %eax
	movzbl	%al, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L19
	jmp	.L17
.L13:
	leaq	addressMemoryMap(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	call	print_memMap
	jmp	.L17
.L12:
	call	envVar
	jmp	.L17
.L11:
	call	clear_screen
	jmp	.L17
.L9:
	call	info
	jmp	.L17
.L8:
	movq	16(%rbp), %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	nop
.L17:
	movl	$31, %ecx
	call	set_text_attr
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC21:
	.ascii "Base address - length - type - acpi_attrs\12\0"
.LC22:
	.ascii "%x | %x | %x | %x\12\0"
	.text
	.globl	print_memMap
	.def	print_memMap;	.scl	2;	.type	32;	.endef
	.seh_proc	print_memMap
print_memMap:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	16(%rbp), %rax
	movq	%rax, -8(%rbp)
	leaq	.LC21(%rip), %rcx
	call	printf
	jmp	.L22
.L23:
	movq	-8(%rbp), %rax
	addq	$40, %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	addq	$32, %rax
	movq	(%rax), %r8
	movq	-8(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rcx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rdx, 32(%rsp)
	movq	%r8, %r9
	movq	%rcx, %r8
	movq	%rax, %rdx
	leaq	.LC22(%rip), %rcx
	call	printf
	addq	$48, -8(%rbp)
.L22:
	movq	-8(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L23
	nop
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC23:
	.ascii "KERNEL_BASE = %x (hex), %d (dec)\12\0"
	.align 8
.LC24:
	.ascii "KERNEL_PAGE_TABLE = %x (hex), %d (dec)\12\0"
	.align 8
.LC25:
	.ascii "TEMP_PAGE = %x (hex), %d (dec)\12\0"
	.align 8
.LC26:
	.ascii "TEMP_PAGE_INFO = %x (hex), %d (dec)\12\0"
.LC27:
	.ascii "sizeof(phyaddr) = %d (dec)\12\0"
	.align 8
.LC28:
	.ascii "----------------------------------\12\0"
	.align 8
.LC29:
	.ascii "TEMP_PAGE >> PAGE_OFFSET_BITS = %x (hex)\12\0"
	.align 8
.LC30:
	.ascii "T>P & PAGE_TABLE_INDEX_MASK = %x (hex)\12\0"
	.align 8
.LC31:
	.ascii "T>P & p * sizeof(phyaddr) = %x (hex)\12\0"
	.text
	.globl	envVar
	.def	envVar;	.scl	2;	.type	32;	.endef
	.seh_proc	envVar
envVar:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	$-4194304, %r8d
	movl	$-4194304, %edx
	leaq	.LC23(%rip), %rcx
	call	printf
	movl	$-8192, %r8d
	movl	$-8192, %edx
	leaq	.LC24(%rip), %rcx
	call	printf
	movl	$-4096, %r8d
	movl	$-4096, %edx
	leaq	.LC25(%rip), %rcx
	call	printf
	movl	$4294967288, %r8d
	movl	$4294967288, %edx
	leaq	.LC26(%rip), %rcx
	call	printf
	movl	$8, %edx
	leaq	.LC27(%rip), %rcx
	call	printf
	leaq	.LC28(%rip), %rcx
	call	printf
	movl	$1048575, %edx
	leaq	.LC29(%rip), %rcx
	call	printf
	movl	$1023, %edx
	leaq	.LC30(%rip), %rcx
	call	printf
	movl	$8184, %edx
	leaq	.LC31(%rip), %rcx
	call	printf
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC32:
	.ascii "IKOS\12\0"
.LC33:
	.ascii "32 bits\12\0"
	.text
	.globl	info
	.def	info;	.scl	2;	.type	32;	.endef
	.seh_proc	info
info:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leaq	.LC32(%rip), %rcx
	call	printf
	leaq	.LC33(%rip), %rcx
	call	printf
	leaq	kernel_page_dir(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	leaq	memory_size(%rip), %rax
	movq	(%rax), %rax
	shrq	$20, %rax
	movq	%rax, %rdx
	leaq	.LC9(%rip), %rcx
	call	printf
	leaq	kernel_page_dir(%rip), %rax
	movq	(%rax), %rax
	movl	$753664, %edx
	movq	%rax, %rcx
	call	get_page_info
	movq	%rax, %rdx
	leaq	.LC10(%rip), %rcx
	call	printf
	leaq	addressMemoryMap(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rdx
	leaq	.LC13(%rip), %rcx
	call	printf
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	init_memory_manager;	.scl	2;	.type	32;	.endef
	.def	init_interrupts;	.scl	2;	.type	32;	.endef
	.def	init_tty;	.scl	2;	.type	32;	.endef
	.def	set_text_attr;	.scl	2;	.type	32;	.endef
	.def	clear_screen;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	get_page_info;	.scl	2;	.type	32;	.endef
	.def	get_free_memory_size;	.scl	2;	.type	32;	.endef
	.def	out_string;	.scl	2;	.type	32;	.endef
	.def	in_string;	.scl	2;	.type	32;	.endef
	.def	strcmp;	.scl	2;	.type	32;	.endef
