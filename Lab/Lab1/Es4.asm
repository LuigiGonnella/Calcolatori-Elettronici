.data
var: .word 0x3FFFFFF0
.text
.globl main
.ent main
main: lw $t0, var
# prima somma
add $t1, $t0, $t0
move $a0, $t1
li $v0, 1
syscall
# seconda somma
# addi $a0, $t1, 40 # scatena l'eccezione di overflowaddiu $a0, $t1, 40
li $v0, 1
syscall
# terza somma
li $t2, 40
# add $a0, $t1, $t2 # scatena l'eccezione di overflowaddu $a0, $t1, $t2
li $v0, 1
syscall
li $v0, 10
syscall
.end main