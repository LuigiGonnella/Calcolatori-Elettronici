.data
opa: .word 2043
opb: .word 5
res: .space 4
msg: .asciiz "Inserisci comando: (somma->0, differenza->1, prodotto->2, divisione->3)\n"
invalid: .asciiz "Numero non valido."
K0=0
K1=1
K2=2
K3=3
	.text
	.globl main
	.ent main

main: lw $t0, opa
lw $t1, opb
la $a0, msg
li $v0, 4
syscall
li $v0, 5 #numero in input
syscall

beq $v0, K0, sum
beq $v0, K1, diff
beq $v0, K2, prod
beq $v0, K3, divi
j exit



sum:
add $t0, $t0, $t1
j store

diff:
sub $t0, $t0, $t1
j store


prod:
mul $t0, $t0, $t1
j store


divi: 
div $t0, $t1
mflo $t0
j store

store: la $s0, res
sw $t0, 0($s0)
move $a0, $t0
li $v0, 1
syscall
li $v0, 10
syscall
.end main

exit:
la $a0, invalid
li $v0, 4
syscall
li $v0, 10
syscall
.end main
