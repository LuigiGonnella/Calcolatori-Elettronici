.data
ore: .byte 2
minuti: .byte 40
secondi: .byte 15
risultato: .word 0
overflow_: .asciiz "Numero genera overflow."
	.text
	.globl main
	.ent main
main:
addi $t0, $0, 60
lb $s0, ore
multu $s0, $t0
mfhi $t4
bne $t4, $0, overflow
mflo $t1
lb $s1, minuti
add $t1, $t1, $s1
lb $s3, secondi
div $s3, $t0
mflo $t2
add $t1, $t1, $t2
sw $t1, risultato
lw $t3, risultato
move $a0, $t3
li $v0, 1
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