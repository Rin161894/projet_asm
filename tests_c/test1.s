	.file	"test.c"
	.option pic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	somme
	.type	somme, @function
somme:
.LFB0:
	.cfi_startproc
	addw	a0,a0,a1
	ret
	.cfi_endproc
.LFE0:
	.size	somme, .-somme
	.ident	"GCC: (GNU) 15.1.0"
	.section	.note.GNU-stack,"",@progbits
