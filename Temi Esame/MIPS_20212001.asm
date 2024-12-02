.data 
DIM=10
DIM1=9
DIM2=12
cognome: .asciiz "ROSSI" 
nome: .asciiz "GENNARO" 
data: .asciiz "120892" 
CF: .space 12 
	.text 
	.globl main 
	.ent main 
main: 
	subu $sp, $sp, 4 
	sw $ra, ($sp) 
 
	la $a0, cognome 
	la $a1, nome 
	la $a2, data 
	la $a3, CF 
	jal CalcoloCF
 
	lw $ra, ($sp) 
	addiu $sp, $sp, 4 
	jr $ra 
.end main 
	
CalcoloCF:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	
	move $t8, $a3
	move $t0, $0
	li $t9, 3
	loop1:
		beq $t0, $t9, lo2
		lb $t1, ($a0)
		addi $a0, $a0, 1
		
		beq $t1, 65, loop1
		beq $t1, 69, loop1
		beq $t1, 73, loop1
		beq $t1, 79, loop1
		beq $t1, 85, loop1
		
		addi $t0, $t0, 1
		sb $t1, ($a3)
		addi $a3, $a3, 1
		
	j loop1
	
	lo2:
		move $t0, $0
	
	loop2:
		
		beq $t0, $t9, dataL
		lb $t1, ($a1)
		addi $a1, $a1, 1
		
		beq $t1, 65, loop2
		beq $t1, 69, loop2
		beq $t1, 73, loop2
		beq $t1, 79, loop2
		beq $t1, 85, loop2
		
		addi $t0, $t0, 1
		sb $t1, ($a3)
		addi $a3, $a3, 1
		
	j loop2
	
	
	dataL:
	
		lb $t1, ($a2)
		sb $t1, ($a3)
		
		addi $a2, $a2, 1
		addi $a3, $a3, 1
		
		lb $t1, ($a2)
		sb $t1, ($a3)
		
		addi $a2, $a2, 1
		addi $a3, $a3, 1
		
		lb $a0, ($a2)
		addi $a2, $a2, 1
		
		lb $a1, ($a2)
		addi $a2, $a2, 1
		
		jal MonthToChar
		
		sb $v0, ($a3)
		addi $a3, $a3, 1
		
		lb $t1, ($a2)
		sb $t1, ($a3)
		
		addi $a2, $a2, 1
		addi $a3, $a3, 1
		
		lb $t1, ($a2)
		sb $t1, ($a3)
		
		
		lb $t4, ($t8)
		addi $t7, $t8, 1
		
		lb $t5, ($t7)
		addi $t7, $t7, 1
		
		xor $t5, $t4, $t5
		move $t0, $0
		
		loopU:
			beq $t0, DIM1, termina
			
			lb $t4, ($t7)
			addi $t7, $t7, 1
			
			xor $t5, $t4, $t5
			addi $t0, $t0, 1
		j loopU
		
		
		termina:
			sb $t5, ($t7)
			
			move $t0, $0
			stampa:
				beq $t0, DIM2, exit
				
				lb $a0, ($t8)
				li $v0, 11
				syscall
				
				li $a0, ' '
				li $v0, 11
				syscall
				
				addi $t8, $t8, 1
				addi $t0, $t0, 1
			j stampa
			
		
		
		
	
	
	
	
	exit:	
		lw $ra, 0($sp)
		addiu $sp, $sp, 4
		jr $ra
.end CalcoloCF
	
	.ent MonthToChar 
MonthToChar: 
 # Parametro in ingresso $a0 = PRIMO CARATTERE
					#$a1= SECONDO CARATTERE
 # (esempio: "01" per Gennaio) 
 # Parametro in uscita $v0 = "A" per l'esempio di Gennaio  # codice della procedura da non sviluppare
	addi $a0, $a0, -48
	addi $a1, $a1, -48
	mul $t0, $a0, DIM
	add $t0, $t0, $a1
	addi $t0, $t0, 64
	move $v0, $t0
	jr $ra 
 .end MonthToChar
 