.data
var: .word 3141592653
 
	.text
	.globl main
	.ent main



main:
lw $t1, var
move $t2, $0
li $t3, 10

loop: beq $t1, $0, print
divu $t1, $t3
mflo $t1
addi $sp, $sp -4
mfhi $t0
sw $t0, ($sp)
addi $t2, $t2, 1
j loop

print: beq $t2, $0, exit
lw $a0, ($sp)
addi $a0, $a0, 48
li $v0, 11
syscall
addi $sp, $sp 4
addi $t2, $t2, -1
j print 

exit:
li $v0, 10
syscall
.end main