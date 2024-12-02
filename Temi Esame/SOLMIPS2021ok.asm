LEN = 4
 .data
testoInChiaro: .asciiz "calcolatorielettronici"
verme: .ascii "mips"
testoCifrato: .space 23
 .text
 .globl main
 .ent main
main: 
 subu $sp, $sp, 4
 sw $ra, 0($sp)
 la $a0, testoInChiaro
 la $a1, verme
 li $a2, LEN
 la $a3, testoCifrato
 jal cifrarioVigenere
 
 move $a0, $v0
 li $v0, 1
 
 syscall
 
 lw $ra, 0($sp)
 addiu $sp, $sp, 4
 jr $ra
 .end main
 
 cifrarioVigenere:
	move $t0, $0
	li $t7, 0
	stampa1:
			add $t8, $a0, $t0
			lb $t9, ($t8)
			beq $t9, $t7, L3
			
			addi $t0, $t0, 1
	j stampa1
 
	L3:
	move $s1, $t8
	li $t9, 0
	move $t0, $0
	move $t1, $0
	move $t7, $0
	li $s0, 'z'
	li $s3, 'a'
	
	loop:
	beq $t0, $a2, exit
	add $t8, $a1, $t0 
	move $t6, $t7
	
	lb $t3, ($t8)
	sub $t3, $t3, $s3

		loop1:
			add $t5, $a0, $t6
			bge $t5, $s1, L1
			lb $t4, ($t5)
			add $t4, $t4, $t3
			ble $t4, $s0, L2
			addi $t4, $t4, -26
			L2:
			add $s2, $a3, $t6
			sb $t4, ($s2)
			add $t6, $t6, $a2
			addi $t1, $t1, 1
		j loop1
 
		L1: 
			addi $t0, $t0, 1
			addi $t7, $t7, 1
	j loop
	
	exit:
		move $t0, $0
		move $t9, $a3
		
		stampa:
			beq $t0, $t1, exit1
			
			add $t2, $t9, $t0
			lb $a0, ($t2)
			li $v0, 11
			syscall
			
			addi $t0, $t0, 1
		j stampa
		
	exit1:
		li $a0, '\n'
		li $v0, 11
		syscall
		move $v0, $t1
		jr $ra
 .end cifrarioVigenere
 
 
