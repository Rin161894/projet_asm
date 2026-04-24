	.file	"bubble.c"
	.option pic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	swap
	.type	swap, @function
swap:
.LFB0:
	.cfi_startproc
	slli	a1,a1,2
	slli	a2,a2,2
	add	a1,a0,a1
	add	a0,a0,a2
	lw	a4,0(a0)
	lw	a5,0(a1)
	sw	a4,0(a1)
	sw	a5,0(a0)
	ret
	.cfi_endproc
.LFE0:
	.size	swap, .-swap
	.align	1
	.globl	bubbleSort
	.type	bubbleSort, @function
bubbleSort:
.LFB1:
	.cfi_startproc
	addi	sp,sp,-64
	.cfi_def_cfa_offset 64
	sd	s0,48(sp)
	sd	s1,40(sp)
	sd	ra,56(sp)
	sd	s2,32(sp)
	sd	s3,24(sp)
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	.cfi_offset 1, -8
	.cfi_offset 18, -32
	.cfi_offset 19, -40
	li	s0,0
	addiw	s1,a1,-1
.L3:
	ble	s1,s0,.L2
	mv	s2,a0
	li	a1,0
	subw	s3,s1,s0
	j	.L7
.L5:
	lw	a4,0(s2)
	lw	a5,4(s2)
	addiw	a2,a1,1
	ble	a4,a5,.L4
	sd	a2,8(sp)
	sd	a0,0(sp)
	call	swap
	ld	a2,8(sp)
	ld	a0,0(sp)
.L4:
	addi	s2,s2,4
	mv	a1,a2
.L7:
	bgt	s3,a1,.L5
	addiw	s0,s0,1
	j	.L3
.L2:
	ld	ra,56(sp)
	.cfi_restore 1
	ld	s0,48(sp)
	.cfi_restore 8
	ld	s1,40(sp)
	.cfi_restore 9
	ld	s2,32(sp)
	.cfi_restore 18
	ld	s3,24(sp)
	.cfi_restore 19
	addi	sp,sp,64
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE1:
	.size	bubbleSort, .-bubbleSort
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC1:
	.string	"%d "
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	li	a5,3
	slli	a5,a5,33
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	addi	a5,a5,5
	sd	a5,0(sp)
	li	a5,3
	slli	a5,a5,32
	addi	a5,a5,1
	li	a1,4
	mv	a0,sp
	sd	s0,16(sp)
	sd	ra,24(sp)
	.cfi_offset 8, -16
	.cfi_offset 1, -8
	sd	a5,8(sp)
	mv	s0,sp
	call	bubbleSort
.L10:
	lw	a1,0(s0)
	lla	a0,.LC1
	addi	s0,s0,4
	call	printf@plt
	addi	a5,sp,16
	bne	s0,a5,.L10
	ld	ra,24(sp)
	.cfi_restore 1
	ld	s0,16(sp)
	.cfi_restore 8
	li	a0,0
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (GNU) 15.1.0"
	.section	.note.GNU-stack,"",@progbits
