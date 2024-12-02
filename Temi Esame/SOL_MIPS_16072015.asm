.data
DIM=9
DIM1=3

mat: 
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 1, 1, 0, 0, 0 
	.byte 0, 0, 0, 0, 1, 1, 0, 0, 0 
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0 
	.byte 0, 0, 1, 1, 1, 1, 0, 0, 0 
	.byte 0, 0, 1, 1, 1, 0, 0, 0, 0 
	.byte 0, 0, 1, 1, 1, 0, 0, 0, 0 
	.byte 0, 0, 0, 0, 1, 0, 0, 0, 0 
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
	
.text
	.globl main
	.ent main

main:
subu $sp, $sp, 4
sw $ra, ($sp)
li $s0, 1
li $t9, DIM
la $a0, mat
move $a1, $0
mul $s1, $t9, $t9

addi $t8, $t9, 1
addi $t7, $t9, 2
move $v0, $0

loop:
	beq $a1, $s1, exit
	
	jal CercaQuad

	addi $a1, $a1, 1
	beq $v0, $s0, exit

j loop

exit:

	move $a0, $v0
	li $v0, 1
	syscall

lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra
.end main


CercaQuad:
    

	add $t0, $a0, $a1
	lb $t1, ($t0)
	bne $t1, $s0, ZERO
	
	addi $t0, $t0, -1
	lb $t1, ($t0)
	bne $t1, $s0, ZERO
	
	addi $t2, $t0, 2
	lb $t1, ($t2)
	bne $t1, $s0, ZERO
	
	sub $t0, $t2, $t9 
	lb $t1, ($t0)
	bne $t1, $s0, ZERO
	
	sub $t0, $t2, $t8
	lb $t1, ($t0)
	bne $t1, $s0, ZERO
	
	sub $t0, $t2, $t7
	lb $t1, ($t0)
	bne $t1, $s0, ZERO
	
	add $t0, $t2, $t9 
	lb $t1, ($t0)
	bne $t1, $s0, ZERO
	
	add $t0, $t2, $t9
	addi $t0, $t0, -1
	lb $t1, ($t0)
	bne $t1, $s0, ZERO
	
	add $t0, $t2, $t9
	addi $t0, $t0, -2
	lb $t1, ($t0)
	bne $t1, $s0, ZERO
	
	li $v0, 1
	
	ZERO:
		jr $ra
.end CercaQuad