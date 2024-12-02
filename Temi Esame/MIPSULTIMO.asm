.data
stringa1: .asciiz "calcolatori elettronici"
stringa2: .asciiz "raccolta"
.text
.globl main
.ent main
main: 
 subu $sp, $sp, 4
 sw $ra, ($sp)

 la $a0, stringa1
 la $a1, stringa2
 jal cercaSequenza
 
 move $a0, $v0
 li $v0, 1
 syscall

 lw $ra, ($sp)
 addiu $sp, $sp, 4
 jr $ra
.end main

cercaSequenza:
	move $t0, $0
	move $t1, $0
	move $t7, $0
	
	loop:
		add $t9, $a1, $t0
		lb $t2, ($t9)
		beq $t2, $0, exit
		move $t8, $a0
		loop1:
			lb $t2, ($t9)
			beq $t2, $0, L4
			lb $t3, ($t8)
			beq $t3, $0, L2
			bne $t2, $t3, L1
			addi $t7, $t7, 1
			addi $t9, $t9, 1
			L1:
				addi $t8, $t8, 1
		j loop1
		L2:
			addi $t0, $t0, 1
			bgt $t7, $t1, L3
			move $t7, $0
			j loop
			L3:
				move $t1, $t7
				move $t7, $0
	j loop
	
	L4:
		bgt $t7, $t1, L5
		addi $t0, $t0, 1
		j loop
		
		L5:
			move $t1, $t7
			addi $t0, $t0, 1
			j loop
		
	exit:
		move $v0, $t1
		jr $ra
.end cercaSequenza