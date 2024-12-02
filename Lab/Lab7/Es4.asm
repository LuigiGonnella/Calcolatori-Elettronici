.data
msgOUT: .asciiz "Valore determinante:\n"
matrice: .word 10, 6, 7, 4
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

jal determinante2x2
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

determinante2x2: 
		mul $t0, $a0, $a3
		mul $t1, $a2, $a1
		sub $v0, $t0, $t1
		jr $ra
.end determinante2x2