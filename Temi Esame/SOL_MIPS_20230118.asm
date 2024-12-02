DIM=7 
.data 
vettore: .byte 11 5 1 4 6 2 12 
.text 
.globl main 
.ent main 
main: 
subu $sp, $sp, 4 
sw $ra, ($sp) 
la $a0, vettore 
li $a1, DIM 
jal EvenParity 
lw $ra, ($sp) 
addiu $sp, $sp, 4 
jr $ra 
.end main


EvenParity:
	move $t0, $0
	move $t2, $a0
	li $t8, 2
	stampa1:
			beq $t0, $a1, L2
			add $t1, $t2, $t0
			lb $a0, ($t1)
			li $v0, 1
			syscall
			li $a0, ' '
			li $v0, 11
			syscall
			addi $t0, $t0, 1
		j stampa1
	
	L2:
	li $a0, '\n'
	li $v0, 11
	syscall
	
	move $a0, $t2
	move $t0, $0
	move $t7, $0
	loop:
		beq $t0, $a1, exit
		add $t2, $a0, $t0
		lb $t3, ($t2)
		move $t4, $0
		move $t5, $0
		
		loop1:
			beq $t5, 4, L1
			andi $t6, $t3, 1
			add $t4, $t4, $t6
			srl $t3, $t3, 1
			addi $t5, $t5, 1
		j loop1
		
		L1:
			div $t4, $t8
			mfhi $t4
			beq $t4, $0, pari
			lb $t3, ($t2)
			ori $t3, $t3, 128
			sb $t3, ($t2)
			addi $t0, $t0, 1
			j loop
			
			pari:
				lb $t3, ($t2)
				andi $t3, $t3, 127
				sb $t3, ($t2)
				addi $t7, $t7, 1
				addi $t0, $t0, 1				
	j loop

	exit:
		move $t0, $0
		move $t2, $a0
		stampa:
			beq $t0, $a1, exit1
			add $t1, $t2, $t0
			lb $a0, ($t1)
			li $v0, 1
			syscall
			li $a0, ' '
			li $v0, 11
			syscall
			addi $t0, $t0, 1
		j stampa
	
	exit1:
		move $v0, $t7
		jr $ra
.end EvenParity










