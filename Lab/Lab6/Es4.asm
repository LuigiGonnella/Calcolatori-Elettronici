.data

VET: .word 1, 20, 3, 4
DIM=4

	.text
	.globl main
	.ent main


main:
move $t0, $0
la $a0, VET
li $a1, DIM
jal max
move $a0, $v0 
li $v0, 1
syscall
li $v0, 10
syscall
.end main

max: li $t1, 0xFFFFFFFF

	loop: beq $t0, $a1, exit
		  addi $t0, $t0, 1
		  lw $t2, ($a0)
		  addi $a0, $a0, 4
		  bgt $t2, $t1, update
		  j loop
		  
	update: move $t1, $t2
			j loop
	

    exit: move $v0, $t1
		  jr $ra
.end max

