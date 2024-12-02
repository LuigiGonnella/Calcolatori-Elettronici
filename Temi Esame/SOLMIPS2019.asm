 .data
DIM=4  
matrice: .word 126, -988, 65, 52 
		 .word 7, 0, 2, 643 
		 .word 66, 532, 43, 9254 
		 .word 5, -51, 4352, -452 
 .text 
 .globl main 
 .ent main 
main: 
 subu $sp, $sp, 4 
 sw $ra, ($sp) 
 la $a0, matrice 
 li $a1, DIM 
 jal calcolaTrasp 
 
 move $s0, $v0
 
 move $t1, $0
 move $t0, $0
 stampa:
 
	loop1:
		beq $t1, $a1, L4
		
		sll $t6, $t1, 2
		sll $t4, $t0, 2
		mul $t5, $t4, $a1
		add $t9, $s0, $t5
		add $t9, $t9, $t6
		lw $a0, ($t9)
		
		li $v0, 1
		syscall
		
		li $a0, ' '
		li $v0, 11
		syscall
		
		addi $t1, $t1, 1
		
	j loop1
	
	L4:
		li $a0, '\n'
		li $v0, 11
		syscall
		addi $t0, $t0, 1
		beq $t0, $a1, L3
	
		move $t1, $0
	
 j stampa
 
 L3:
 lw $ra, ($sp) 
 addiu $sp, $sp, 4 
 jr $ra
.end main


calcolaTrasp:
	move $t1, $0 #j
	move $t2, $0 #i
	addi $t3, $a1, -1
	
	loop:
		beq $t2, $t3, exit
		beq $t1, $a1, L2
		beq $t1, $t2, L1
		
		sll $t0, $t1, 2
		sll $t4, $t2, 2
		mul $t5, $t4, $a1
		add $t9, $a0, $t5
		add $t9, $t9, $t0 #indirizzo elemento
		lw $t7, ($t9)
		
		sll $t0, $t2, 2
		sll $t4, $t1, 2
		mul $t5, $t4, $a1
		add $t8, $a0, $t5
		add $t8, $t8, $t0 #indirizzo elemento con cui scambiare
		lw $t6, ($t8)
		
		sw $t7, ($t8)
		sw $t6, ($t9)  #faccio scambio
		
		addi $t1, $t1, 1
		
		j loop
		
		
		
		L1:
			addi $t1, $t1, 1
			j loop
			
			
			
		L2:
			addi $t2, $t2, 1
			move $t1, $0
			add $t1, $t1, $t2
			j loop
	
	exit:
	move $v0, $a0
	jr $ra
.end calcolaTrasp