.data
message: .asciiz "Scrivi il numero di valori da inserire:"
message1: .asciiz "Inserisci i valori:"
media: .asciiz "Media:"
	.text
	.globl main
	.ent main
main:
la $a0, message
li $v0, 4
syscall
li $v0, 5
syscall 
move $t0, $v0
la $a0, message1
li $v0, 4
syscall

addi $s0, $0, 0
addi $s1, $0, 0
loop: beq $s0, $t0, L1
li $v0, 5
syscall
add $s1, $s1, $v0
addi $s0, $s0, 1
j loop

L1: la $a0, media
li $v0, 4
syscall
div $s1, $t0
mflo $a0
li $v0, 1
syscall
li $v0, 10
syscall

