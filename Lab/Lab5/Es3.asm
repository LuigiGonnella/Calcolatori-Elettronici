.data
 msg: .asciiz "Inserisci un valore numerico per A, B e C:\n"
 fail: .asciiz "NON esistono soluzioni reali"
 unica: .asciiz "Esistono due soluzioni coincidenti"
 diverse: .asciiz "Esistono due soluzioni NON coincidenti"
	
	.text
	.globl main
	.ent main


main:
la $a0, msg
li $v0, 4
syscall
li $v0, 5
syscall 
move $t0, $v0
li $v0, 5
syscall 
move $t1, $v0
li $v0, 5
syscall 
move $t2, $v0
mul $t1, $t1, $t1 #metto in t1 B^2
mul $t0, $t0, $t2 #AxC
addi $t3, $0, 4
mul $t0, $t0, $t3 # 4AxC
sub $t0, $t1, $t0 # B^2-4AxC
slt $t5, $t0, $0
bne $t5, $0, fail_
beq $t0, $0, unica_

diverse_:
la $a0, diverse
li $v0, 4
syscall
j exit

fail_:
la $a0, fail
li $v0, 4
syscall
j exit

unica_:
la $a0, unica
li $v0, 4
syscall


exit:
li $v0, 10
syscall
.end main