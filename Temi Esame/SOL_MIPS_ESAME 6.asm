DIM = 11
 .data
	veta: .word 2, 14, 8, 54, 0, 42, 9, 24, 0, 91, 23
	vetb: .space 4*DIM
	msgout1: .asciiz "veta: "
	msgout2: .asciiz "vetb: "
 .text
 .globl main
 .ent main
main: 
subu $sp, $sp, 4
sw $ra, ($sp)
la $a0, veta
la $a1, vetb
li $a2, DIM
jal media
lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra
.end main


media: 
	lw $t0, ($a0)
	lw $t1, 4($a0)
	
	sw $t0, ($a1)
	sw $t1, 4($a1)
	
	move $t0, $a0
	move $t1, $a1	
	
	addi $t0, $t0, 8
	addi $t1, $t1, 8
	
	move $t2, $0
	move $t9, $a2
	addi $t9, $t9, -3
	loop:
		beq $t2, $t9, L1
		lw $t5, ($t0)
		addi $t0, $t0, -4
		lw $t6, ($t0)
		addi $t0, $t0, -4
		lw $t7, ($t0)
		addi $t0, $t0, 12
		lw $t8, ($t0)
		add $t7, $t7, $t8
		add $t6, $t6, $t7
		add $t5, $t5, $t6
		srl $t5, $t5, 2
		sw $t5, ($t1)
		addi $t1, $t1, 4
		addi $t2, $t2, 1
	j loop
	
	L1:
		lw $t5, ($t0)
		sw $t5, ($t1)
	
	move $t3, $0
	
	move $t4, $a0
	la $a0, msgout1
	li $v0, 4
	syscall
	
	stampaA:
		beq $t3, $a2, L2
		sll $t2, $t3, 2
		add $t6, $t4, $t2
		lw $a0, ($t6)
		li $v0, 1
		syscall
		
		li $a0, ' '
		li $v0, 11
		syscall
		
		addi $t3, $t3, 1
	j stampaA
	
	L2:
		move $t3, $0
		
		move $t4, $a1
		la $a0, msgout2
		li $v0, 4
		syscall
	
	stampaB:
		beq $t3, $a2, exit
		sll $t2, $t3, 2
		add $t6, $t4, $t2
		
		lw $a0, ($t6)
		li $v0, 1
		syscall
		
		li $a0, ' '
		li $v0, 11
		syscall
		
		addi $t3, $t3, 1
	j stampaB
	
	exit:
		jr $ra
.end media