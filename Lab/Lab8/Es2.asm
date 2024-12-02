LUNG = 6
.data
anni: .word 1945, 2008, 1800, 2006, 1748, 1600
ris: .space LUNG
	.text
	.globl main
	.ent main
main: 
subu $sp, $sp, 4
sw $ra, 0($sp)

la $a0, anni
la $a1, ris
li $a2, LUNG
jal bisestile

lw $ra 0($sp)
addiu $sp, $sp, 4
jr $ra
.end main


bisestile: 
		li $t8, 100
		li $t7, 4
		move $t6, $0
		li $t5, 1
		move $t0, $0 #i
		move $t9, $0 #j
		loop: 
			beq $t0, LUNG, stampa
			lw $t2, ($a0)
			add $a0, $a0, $t7
			
			div $t3, $t2, $t8
			mfhi $t3
			beq $t3, $0, secolare #e' secolare
			
			div $t3, $t2, $t7
			mfhi $t3
			beq $t3, $0, bisestile1 #e' bisestile
			j nonbisestile #non e' bisestile
			
			secolare:
				mul $t3, $t8, $t7 #400
				div $t3, $t2, $t3
				mfhi $t3
				beq $t3, $0, bisestile1
				j nonbisestile
			
			bisestile1:
			add $t4, $a1, $t9
			sb $t5, ($t4)
			
			addi $t9, $t9, 1
			addi $t0, $t0, 1
		j loop
			
			nonbisestile:
			add $t4, $a1, $t9
			sb $t6, ($t4)
			
			addi $t9, $t9, 1
			addi $t0, $t0, 1
		j loop
			
		
		stampa:
			move $t9, $0
			loops:
				beq $t9, LUNG, exit
				lb $a0, ($a1)
				addi $a1, $a1, 1
				li $v0, 1
				syscall
				li $a0, ' '
				li $v0, 11
				syscall
				addi $t9, $t9, 1
			j loops
		exit:
			jr $ra
.end bisestile