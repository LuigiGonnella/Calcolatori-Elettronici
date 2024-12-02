.data
N=7

	.text
	.globl main
	.ent main
	
main:
li $a0, N

subu $sp, $sp, 4
sw $ra, ($sp)

jal calcolaSuccessivo

lw $ra, ($sp)
addiu $sp, $sp, 4

move $a0, $v0
li $v0, 1
syscall

jr $ra
.end main


calcolaSuccessivo: 
		li $t0, 2
		div $a0, $t0
		mfhi $t1
		beq $t1, $0, exitP
		j exitD
		
		exitP:
		div $v0, $a0, $t0
		jr $ra
		
		exitD:
		li $t2, 3
		mul $v0, $a0, $t2
		addi $v0, $v0, 1
		jr $ra
.end calcolaSuccessivo