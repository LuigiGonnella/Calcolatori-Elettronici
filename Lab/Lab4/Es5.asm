.data
dim_r=4
dim_c=6
dim_c1=5
dim_r1=3
tab: .word 154, 123, 109, 86, 4, 0
	 .word 412, -23, -231, 9, 50, 0
	 .word 123, -24, 12, 55, -45, 0
	 .word 0, 0, 0, 0, 0, 0
 
	.text
	.globl main
	.ent main

main:
la $s0, tab #indirizzo base tabella
move $t0, $0 #i=0
move $t1, $0 #j=0
move $t4, $0 #somma righe
move $t6, $0 #i*4

loop_j: 
beq $t1, dim_c1, loop_i
sll $t6, $t0, 2
mul $t7, $t6, dim_c
sll $t2, $t1, 2 #j*4
add $t3, $s0, $t2 #tab[0][0]+j*4
add $t3, $t3, $t7 #tab[0][0]+j*4+i*4*dim_c
lw $t5, 0($t3) #tab[i][j]
move $a0, $t5
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall
add $t4, $t4, $t5 #somma
addi $t1, $t1, 1 #j+1
j loop_j

loop_i:
mul $t7, $t6, dim_c
sll $t2, $t1, 2 #j*4
add $t3, $s0, $t2 #tab[0][0]+j*4
add $t3, $t3, $t7 #tab[0][0]+j*4+i*4*dim_c
sw $t4, 0($t3)
move $a0, $t4
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
move $t4, $0
move $t1, $0
addi $t0, $t0, 1
beq $t0, dim_r1, L1
j loop_j

L1:
move $t0, $0 #j=0
move $t1, $0 #i=0
move $t4, $0 #somma colonne
move $t6, $0 #j*4

loop_i1: 
beq $t1, dim_r1, loop_j1
sll $t6, $t1, 2
mul $t7, $t6, dim_c
sll $t2, $t0, 2 #j*4
add $t3, $s0, $t2 #tab[0][0]+j*4
add $t3, $t3, $t7 #tab[0][0]+j*4+i*4*dim_c
lw $t5, 0($t3) #tab[i][j]
add $t4, $t4, $t5 #somma
addi $t1, $t1, 1 #j+1
j loop_i1

loop_j1:
sll $t6, $t1, 2
mul $t7, $t6, dim_c
sll $t2, $t0, 2 #j*4
add $t3, $s0, $t2 #tab[0][0]+j*4
add $t3, $t3, $t7 #tab[0][0]+j*4+i*4*dim_c
sw $t4, 0($t3)
move $a0, $t4
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall
move $t4, $0
move $t1, $0
addi $t0, $t0, 1
beq $t0, dim_c, exit
j loop_i1

exit:
li $v0, 10
syscall
.end main