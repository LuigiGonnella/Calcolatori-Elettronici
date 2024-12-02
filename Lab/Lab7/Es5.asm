.data
msgOUT: .asciiz "Valore determinante:\n"
matrice: .word 0, 2, 3, 4, 5, 6, 7, 8, 9

	.text
	.globl main
	.ent main
	
main:
subu $sp, $sp, 4
sw $ra, ($sp)


la $s0, matrice
lw $a0, 0($s0)
lw $a1, 4($s0)
lw $a2, 8($s0)
lw $a3, 12($s0)

lw $t0, 16($s0)
lw $t1, 20($s0)
lw $t2, 24($s0)
lw $t3, 28($s0)
lw $t4, 32($s0)


subu $sp, $sp, 20
sw $t0, 0($sp)
sw $t1, 4($sp)
sw $t2, 8($sp)
sw $t3, 12($sp)
sw $t4, 16($sp)




jal determinante3x3
move $s1, $v0

la $a0, msgOUT
li $v0, 4
syscall

move $a0, $s1
li $v0, 1
syscall

lw $ra ($sp)
addiu $sp, $sp, 4
jr $ra
.end main


determinante3x3: 
		lw $t4, 0($sp)
		lw $t5, 4($sp)
		lw $t6, 8($sp)
		lw $t7, 12($sp)
		lw $t8, 16($sp)
		addiu $sp, $sp, 20
		
		subu $sp, $sp, 4
		sw $ra, ($sp)
		
		move $t0, $a0
		move $t1, $a1
		move $t2, $a2  #elementi da moltiplicare ai determinanti2x2
		
		move $t3, $a3  #quarto elemento matrice
		
		move $a0, $t4
		move $a1, $t5
		move $a2, $t7
		move $a3, $t8  #elementi prima sotto-matrice 2x2
		
		subu $sp, $sp, 8
		sw $t0, ($sp)
		sw $t1, 4($sp)
		jal determinante2x2
		lw $t0, 0($sp)
		lw $t1, 4($sp)
		addiu $sp, $sp, 8
		move $s2, $v0 
		mul $s2, $s2, $t0 #risultato primo termine in s2
		
		move $a0, $t3
		move $a1, $t5
		move $a2, $t6
		move $a3, $t8  #elementi seconda sotto-matrice 2x2
		
		subu $sp, $sp, 8
		sw $t0, ($sp)
		sw $t1, 4($sp)
		jal determinante2x2
		lw $t0, 0($sp)
		lw $t1, 4($sp)
		addiu $sp, $sp, 8
		move $s3, $v0 
		mul $s3, $s3, $t1 #risultato secondo termine in s3
		
		move $a0, $t3
		move $a1, $t4
		move $a2, $t6
		move $a3, $t7  #elementi terza sotto-matrice 2x2
		
		subu $sp, $sp, 8
		sw $t0, ($sp)
		sw $t1, 4($sp)
		jal determinante2x2
		lw $t0, 0($sp)
		lw $t1, 4($sp)
		addiu $sp, $sp, 8
		move $s4, $v0 
		mul $s4, $s4, $t2 #risultato terzo termine in s4
		
		sub $v0, $s2, $s3
		add $v0, $v0, $s4
		
		
		

		lw $ra ($sp)
		addiu $sp, $sp, 4
		jr $ra
.end determinante3x3


determinante2x2: 
		mul $t0, $a0, $a3
		mul $t1, $a2, $a1
		sub $v0, $t0, $t1
		jr $ra
.end determinante2x2