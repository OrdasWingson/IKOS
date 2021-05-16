	.file	"listFS.c"
	.text
	.comm	_headFS, 4, 2
	.globl	_init_FS
	.def	_init_FS;	.scl	2;	.type	32;	.endef
_init_FS:
LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	movl	%eax, _headFS
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE0:
	.section .rdata,"dr"
	.align 4
LC0:
	.ascii "FS INFO\12FS magic number addres 0x%x\12\0"
LC1:
	.ascii "FS magic number 0x%x\12\0"
LC2:
	.ascii "FS version 0x%x\12\0"
LC3:
	.ascii "FS flags 0x%x\12\0"
LC4:
	.ascii "FS base sector %d\12\0"
LC5:
	.ascii "FS size (sectors) %d\12\0"
LC6:
	.ascii "FS map base addres 0x%x\12\0"
LC7:
	.ascii "FS map size 0x%x\12\0"
LC8:
	.ascii "FS sector of first file %d\12\0"
LC9:
	.ascii "FS uid 0x%x\12\0"
LC10:
	.ascii "FS block size %d\12\0"
	.text
	.globl	_fsInfo
	.def	_fsInfo;	.scl	2;	.type	32;	.endef
_fsInfo:
LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	_headFS, %eax
	movl	%eax, 4(%esp)
	movl	$LC0, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC1, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	4(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	16(%eax), %edx
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	%edx, 8(%esp)
	movl	$LC4, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	24(%eax), %edx
	movl	20(%eax), %eax
	movl	%eax, 4(%esp)
	movl	%edx, 8(%esp)
	movl	$LC5, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	32(%eax), %edx
	movl	28(%eax), %eax
	movl	%eax, 4(%esp)
	movl	%edx, 8(%esp)
	movl	$LC6, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	40(%eax), %edx
	movl	36(%eax), %eax
	movl	%eax, 4(%esp)
	movl	%edx, 8(%esp)
	movl	$LC7, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	48(%eax), %edx
	movl	44(%eax), %eax
	movl	%eax, 4(%esp)
	movl	%edx, 8(%esp)
	movl	$LC8, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	56(%eax), %edx
	movl	52(%eax), %eax
	movl	%eax, 4(%esp)
	movl	%edx, 8(%esp)
	movl	$LC9, (%esp)
	call	_printf
	movl	_headFS, %eax
	movl	60(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC10, (%esp)
	call	_printf
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE1:
	.globl	_first_file_name
	.def	_first_file_name;	.scl	2;	.type	32;	.endef
_first_file_name:
LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$69632, 8(%esp)
	movl	$1, 4(%esp)
	movl	$2, (%esp)
	call	_ata_lba_read
	movl	$69632, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2:
	.ident	"GCC: (MinGW.org GCC-8.2.0-5) 8.2.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_ata_lba_read;	.scl	2;	.type	32;	.endef
