.data
message: .asciiz "Inserisci un numero pisitivo: "
error: .asciiz "Numero non rappresentabile"
	.text
	.globl main
	.ent main
main:
li $s0, 255
la $a0, message
li $v0, 4
syscall
li $v0, 5
syscall
move $t0, $v0
bgtu $t0, $s0, L1
la $a0, message
li $v0, 4
syscall
li $v0, 5
syscall
move $t1, $v0
bgtu $t1, $s0, L1
xor $s1, $t0, $t1
nor $s2, $t0, $0
and $s3, $t0, $s2
nor $s4, $t3, $0
or $s5, $s4, $s1 
and $s5, $s5, 0x000000FF
move $a0, $s5
li $v0, 1
syscall
j target
L1: la $a0, error
	syscall
target: li $v0, 10
		syscall
		.end main


