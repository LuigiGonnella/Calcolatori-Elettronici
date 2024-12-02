.data
 msg: .asciiz "Inserisci stringa:"
 error: .asciiz "Parola non palindroma"
 ok: .asciiz "Parola palindroma"
	.text
	.globl main
	.ent main


main:
la $a0, msg
li $v0, 4
syscall

li $v0, 12
syscall
addi $sp, $sp, -4
sw $v0, ($sp)
move $t1, $sp

loop: 
li $v0, 12
syscall
beq $v0,'\n', vett
subu $sp, $sp, 4
sw $v0, ($sp)
j loop

vett: move $t2, $sp

pal: lw $t3, ($t1)
lw $t4, ($t2)
bne $t3, $t4, fail
bgt $t2, $t1, success
addi $t2, $t2, 4
addi $t1, $t1, -4
j pal


success: la $a0, ok
li $v0, 4
syscall
j exit


fail: la $a0, error
li $v0, 4
syscall
j exit


exit:
li $v0, 10
syscall
.end main