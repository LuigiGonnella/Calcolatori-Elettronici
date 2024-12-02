.data 
espressione: .word 18, 25, 10, 7, -2, -3, -1, 13, -2 
tabella: .word somma, sottrazione, moltiplicazione, divisione 
 .text 
 .globl main 
 .ent main 
main: 
 subu $sp, $sp, 4 
 sw $ra, ($sp) 
 la $a0, espressione 
 li $a1, 9 
 jal calcolaPolaccaInversa 
 
 lw $a0, ($sp)
 addiu $sp, $sp, 4

 li $v0, 1
 syscall
 
 lw $ra, ($sp) 
 addu $sp, $sp, 4 
 jr $ra 
.end main 


eseguiOperazione: 
 subu $t0, $zero, $a0 
 subu $t0, $t0, 1 
 sll $t0, $t0, 2 
 lw $t1, tabella($t0) 
 jr $t1 
somma: addu $v0, $a1, $a2 
 b fine 
sottrazione: subu $v0, $a1, $a2 
 b fine 
moltiplicazione: mulou $v0, $a1, $a2 
 b fine 
divisione: divu $v0, $a1, $a2 
 b fine 
fine: jr $ra


calcolaPolaccaInversa:
	
	move $t9, $a0
	move $t8, $a1
	
	move $t3, $0
	
	

	loop:
		beq $t3, $t8, exit
		sll $t2, $t3, 2
		add $t6, $t9, $t2
		lw $t4, ($t6)
		blt $t4, $0, L1
		subu $sp, $sp, 4
		sw $t4, 0($sp)
		addi $t3, $t3, 1
		
		j loop
		L1:
			lw $a2, 0($sp)
			lw $a1, 4($sp)
			addiu $sp, $sp, 8
			move $a0, $t4
			
			subu $sp, $sp, 4
			sw $ra, 0($sp)
			jal eseguiOperazione
			lw $ra, ($sp)
			addiu $sp, $sp 4
			
			subu $sp, $sp, 4
			sw $v0, 0($sp)
			
			addi $t3, $t3, 1	
	j loop


	exit:
		jr $ra
.end calcolaPolaccaInversa