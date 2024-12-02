.data
ora_in: .byte 12, 47
ora_out: .byte 18, 14
X: .byte 1
Y: .byte 40
	.text
	.globl main

main: 
subu $sp, $sp, 4
sw $ra, 0($sp)

la $a0, ora_in # indirizzo di ora_in
la $a1, ora_out # indirizzo di ora_out
lbu $a2, X
lbu $a3, Y
jal costoParcheggio

move $a0, $v0
li $v0, 1
syscall

lw $ra, 0($sp)
addiu $sp, $sp, 4
jr $ra
.end main 


costoParcheggio: 
	li $t4, 60

	lbu $t0, 0($a0) #ora di inizio 
	lbu $t1, 1($a0) #minuti di inizio 
	
	lbu $t2, 0($a1) #ora di fine 
	lbu $t3, 1($a1) #minuti di fine 
	
	mul $t0, $t0, $t4
	mul $t2, $t2, $t4
	
	add $t2, $t2, $t3 #minuti totali di fine
	add $t0, $t0, $t1 #minuti totali di inizio
	
	sub $t0, $t2, $t0 #minuti di sosta
	
	div $t0, $t0, $a3  #numero di periodi intero
	mfhi $t1
	
	bne $t1, $0, L1
	mul $v0, $t0, $a2
	jr $ra
	
	L1: 
		addi $t0, $t0, 1 #numero totale periodi
		mul $v0, $t0, $a2
	jr $ra
.end costoParcheggio