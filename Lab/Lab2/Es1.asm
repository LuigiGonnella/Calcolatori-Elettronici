	.data
message: .asciiz "Inserisci un intero positivo: "
pari: .asciiz "Il numero e' pari "
dispari: .asciiz "Il numero e' dispari "
	.text
	.globl main
	.ent main
main:
la $a0, message
li $v0, 4
syscall
li $v0, 5
syscall
move $t1, $v0
andi $t2, $t1, 1
beq $t2,$0, L1
la $a0, dispari
li $v0, 4
syscall
j target 
L1: la $a0, pari
	li $v0, 4
	syscall 
target: li $v0, 10
		syscall
		.end main
		