.data
DIM=4
 matrix: .word 1, 0, 0, 0
		 .word 0, 2, 0, 0
		 .word 0, 0, 3, 0
		 .word 0, 0, 0, 4
	
	.text
	.globl main
	.ent main


main:
la $t0, matrix
add $t1, $t0, $0
addi $t3, $0, DIM
addi $t6, $t3, -1 #num. elem. da leggere su una riga/colonna
move $t7, $0 #num. elem. letti
move $s0, $0
li $t8, 1
move $s1, $0

diag:
addi $s0, $s0, 1
addi $t1, $t1, 4
sll $t2, $t3, 2
mul $t2, $t2, $s0
add $t2, $t0, $t2
lw $t4, ($t1)
lw $t5, ($t2)
bne $t4, $t5, not_s
addi $t7, $t7, 1 #letto un elem.
bne $t4, $0, sim
beq $t7, $t6, loop
j diag


loop:
beq $t6, $t8, print
move $t7, $0
move $s0, $0
addi $t6, $t6, -1
sll $t9, $t3, 2
addi $t9, $t9, 4
add $t0, $t0, $t9
add $t1, $t0, $0
beq $s1, $0, diag
j sim



sim:
addi $s1, $0, 1 
addi $s0, $s0, 1
addi $t1, $t1, 4
sll $t2, $t3, 2
mul $t2, $t2, $s0
add $t2, $t0, $t2
lw $t4, ($t1)
lw $t5, ($t2)
bne $t4, $t5, not_s
addi $t7, $t7, 1 #letto un elem.
beq $t7, $t6, loop
j sim

not_s:
move $a0, $0
j exit



print:
beq $t4, $0, diag_print
li $a0, 1
j exit



diag_print:
li $a0, 2
j exit


exit:
li $v0, 1
syscall
li $v0, 10
syscall
.end main