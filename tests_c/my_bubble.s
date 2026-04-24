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
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	mv	a4,a2
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a5,-44(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-20(s0)
	lw	a5,-48(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-44(s0)
	slli	a5,a5,2
	ld	a3,-40(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-48(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,0(a5)
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
.LFE0:
	.size	swap, .-swap
	.align	1
	.globl	bubbleSort
	.type	bubbleSort, @function
bubbleSort:
.LFB1:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	sw	zero,-20(s0)
	j	.L3
.L7:
	sw	zero,-24(s0)
	j	.L4
.L6:
	lw	a5,-24(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	ld	a3,-40(s0)
	add	a5,a3,a5
	lw	a5,0(a5)
	ble	a4,a5,.L5
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sext.w	a4,a5
	lw	a5,-24(s0)
	mv	a2,a4
	mv	a1,a5
	ld	a0,-40(s0)
	call	swap
.L5:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L4:
	lw	a5,-44(s0)
	mv	a4,a5
	lw	a5,-20(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lw	a4,-24(s0)
	sext.w	a4,a4
	blt	a4,a5,.L6
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L3:
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	lw	a4,-20(s0)
	sext.w	a4,a4
	blt	a4,a5,.L7
	nop
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
.LFE1:
	.size	bubbleSort, .-bubbleSort
	.section	.rodata
	.align	3
.LC1:
	.string	"%d "
	.align	3
.LC0:
	.word	5
	.word	6
	.word	1
	.word	3
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB2:
	# Prologue du programme
	addi sp,sp,-48 # alloue la pile
	sd	 ra,40(sp) # sauvegarde ra
	sd	 s0,32(sp) # sauvegarde s0
	addi s0,sp,48  # frame pointer
	lla	a5,.LC0
	ld	a4,0(a5)
	sd	a4,-40(s0)
	ld	a5,8(a5)
	sd	a5,-32(s0)
	li	a5,4
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	addi	a5,s0,-40
	mv	a1,a4
	mv	a0,a5
	call	bubbleSort
	sw	zero,-20(s0)
	j	.L9
.L10:
	lw	a4,-20(s0)
	addi	a5,s0,-40
	slli	a4,a4,2
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a1,a5
	lla	a0,.LC1
	call	printf@plt
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L9:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L10
	li	a5,0
	mv	a0,a5
	# Epilogue du programme
	ld	ra,40(sp) # restaure ra
	ld	s0,32(sp) # restaure s0
	addi	sp,sp,48  # libère la pile
	jr	ra	  # retour
.LFE2:
	.size	main, .-main
	.ident	"GCC: (GNU) 15.1.0"
	.section	.note.GNU-stack,"",@progbits
