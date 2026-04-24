	.file	"test.c"
	.option pic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	somme
	.type	somme, @function
somme:
.LFB0:
	.cfi_startproc
	add	a0,a0,a1
	ret
	.cfi_endproc
.LFE0:
	.size	somme, .-somme
	.ident	"GCC: (GNU) 15.1.0"
	.section	.note.GNU-stack,"",@progbits
