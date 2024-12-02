.data
dim=4
row: .word 0, 1, 2, 3
col: .word 0, 1, 2, 3
tab: .space 64
 
	.text
	.globl main
	.ent main

main: move $t0, $0 #elemento riga
move $t1, $0 #elemento col
move $t2, $0 #indice i
move $t3, $0 #indice j
la $s0, row #indirizzo base row
la $s1, col #indirizzo base col
la $t6, tab #indirizzo base tab

loop_i: beq $t2, dim, exit
move $t3, $0
li $a0, '\n'
li $v0, 11
syscall
sll $t4, $t2, 2
add $t7, $s0, $t4
lw $t0, 0($t7)
addi $t2, $t2, 1

	loop_j: beq $t3, dim, loop_i
	sll $t5, $t3, 2
	add $t8, $s1, $t5
	lw $t1, 0($t8)
	mul $t9, $t0, $t1
	move $a0, $t9
	li $v0, 1
	syscall
	li $a0, ' '
	li $v0, 11
	syscall
	sw $t9, 0($t6)
	addi $t6, $t6, 4
	addi $t3, $t3, 1
	j loop_j
	
exit: li $v0, 10
syscall
.end main