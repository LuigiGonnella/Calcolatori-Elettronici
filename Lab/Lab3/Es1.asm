	.data
message: .asciiz "Inserisci un numero unsigned (invio per uscire):"
error_: .asciiz "Numero inserito non corretto."
correct: .asciiz "Numero inserito corretto."
	.text
	.globl main
	.ent main
main:
la $a0, message
li $v0, 4
syscall

loop: 
	li $v0, 12
	syscall
	move $t0, $v0
	beq $t0, 10, target
	bgt $t0, 57, error
	blt $t0, 48, error 
	j loop
target: la $a0, correct
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	.end main
		
error: la $a0, error_
	li $v0, 4
	syscall	
	li $v0, 10
	syscall
	.end main
