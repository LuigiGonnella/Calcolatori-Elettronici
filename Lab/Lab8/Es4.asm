DIM = 5
.data
vet1: .word 56, 12, 98, 129, 58 #5 word
vet2: .word 1, 0, 245, 129, 12
risultato: .space DIM # 5 byte
	.text
	.globl main
	.ent main
main: 
subu $sp, $sp, 4
sw $ra, 0($sp)

la $a0, vet1
la $a1, vet2
la $a2, risultato
li $a3, DIM
jal CalcolaDistanzaH

lw $ra, 0($sp)
addiu $sp, $sp, 4
jr $ra
.end main


CalcolaDistanzaH:
	subu $sp, $sp, 8
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	
	move $t0, $0 # i=contatore elementi in vet1 e vet2 (e anche offset per risultato)
	move $t6, $0 # contatore bit
	move $t8, $0 # registro che memorizza il numero di bit diversi per ogni coppia
	li $t9, 32 # num. bit totali
	loop1: 
		beq $t0, $a3, exit # per i 5 numeri
		sll $t1, $t0, 2 #i*4
		
		add $t2, $a0, $t1 # indirizzi elem. correnti
		add $t3, $a1, $t1
		
		lw $t4, ($t2) #elem. correnti
		lw $t5, ($t3)
		
		beq $t4, $t5, Insert # se sono uguali salvo direttamente 0 in risultato
		
		loop2:
			beq $t6, $t9, Insert # per i 32 bit
			
			andi $s0, $t4, 1 # memorizzo bit meno sign. per entrambi i numeri
			andi $s1, $t5, 1
			
			beq $s0, $s1, Nupdate # se sono uguali non aggiorno t8
			
			addi $t8, $t8, 1 # se sono diversi aggiorno t8
			
			srl $t4, $t4, 1 # passo al bit successivo e ripeto i passaggi
			srl $t5, $t5, 1
			
			addi $t6, $t6, 1
			
			j loop2
			
			Nupdate: # passo al bit successivo e ripeto i passaggi senza aggiornare t8
				srl $t4, $t4, 1
				srl $t5, $t5, 1
			
				addi $t6, $t6, 1	
		j loop2
		
		Insert:  
			add $t7, $a2, $t0 #indirizzo di risultato in cui inserire t8 
			sb $t8, ($t7)
		
	
	addi $t0, $t0, 1	 #aggiorno t0 e azzero t6 e t8
	move $t6, $0
	move $t8, $0
	j loop1

	exit:
		move $t0, $0
		loops: # ciclo di stampa del risultato
			beq $t0, $a3, L1
			lb $a0, ($a2)
			li $v0, 1
			syscall
			
			li $a0, ' '
			li $v0, 11
			syscall
			
			addi $a2, $a2, 1
			addi $t0, $t0, 1
		j loops
	
	L1:
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		addiu $sp, $sp, 8
		jr $ra
.end CalcolaDistanzaH