.data
message: .asciiz "Inserisci un numero unsigned (invio per uscire):"
error_: .asciiz "Numero inserito non corretto."
overflow_: .asciiz "Numero inserito genera overflow."
	.text
	.globl main
	.ent main
main:
la $a0, message
li $v0, 4
syscall
addi $s0, $0, 0
addi $t2, $0, 10
loop: 
	li $v0, 12
	syscall
	move $t0, $v0
	beq $t0, 10, target
	bgt $t0, 57, error
	blt $t0, 48, error 
	addi $t0, $t0, -48
	multu $s0, $t2
	mfhi $t4
	bne $t4, $0, overflow
	mflo $t1
	add $s0, $t1, $t0
	j loop
target: 
	and $t3, $s0, 0xFFFF0000
	bne $t3, $0, error
	move $a0, $s0
	li $v0, 1
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

overflow: la $a0, overflow_
	li $v0, 4
	syscall	
	li $v0, 10
	syscall
	.end main