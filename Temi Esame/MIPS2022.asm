.data
vettore: .byte 14, 16, 18, 134, 24, 22, 23, 149, 140, 141, 145, 146
vettoreCompresso: .space 12
INTERVALLO_QUANT = 10
 .text
 .globl main
 .ent main
main:
 subu $sp, $sp, 4
 sw $ra, ($sp)
 la $a0, vettore
 li $a1, 12
 la $a2, vettoreCompresso
 jal comprimi

move $t0, $0
move $t1, $v0

stampa:
	beq $t0, $t1, exit1
	add $t3, $a2, $t0
	lbu $a0, ($t3)
	li $v0, 1
	syscall
	li $a0, ' '
	li $v0, 11
	syscall
	addi $t0, $t0, 1
j stampa

exit1:
 lw $ra, ($sp)
 addu $sp, $sp, 4
 jr $ra
 .end main
 
quantizza:
 divu $t0, $a0, INTERVALLO_QUANT
 mulou $v0, $t0, INTERVALLO_QUANT
 jr $ra
 .end quantizza
 
comprimi:
	subu $sp, $sp, 4
	sw $ra, ($sp)

	move $t1, $0
	move $t8, $a0
	
	loop:
		beq $t1, $a1, L1
		
		add $t9, $t1, $t8
		lbu $a0, ($t9)
		
		jal quantizza
		
		sb $v0, ($t9)
		
		addi $t1, $t1, 1
	j loop
	
	L1:
		li $t1, 1
		li $t2, 1
		
		addi $a1, $a1, -1
		
		lbu $t3, ($t8)
		sb $t3, ($a2)
		
		loop1:
			beq $t1, $a1, exit
			
			add $t7, $t8, $t1
			lbu $t4, ($t7)
			
			beq $t3, $t4, L2
			
			add $t5, $t2, $a2 
			sb $t4, ($t5)
			addi $t2, $t2, 1
			addi $t1, $t1, 1
			move $t3, $t4
			j loop1
			
			L2: 
				addi $t1, $t1, 1	
		j loop1
	
	exit:
		move $v0, $t2
		lw $ra, ($sp)
		addiu $sp, $sp, 4
		jr $ra
.end comprimi