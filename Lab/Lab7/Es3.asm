.data
msg: .asciiz "Inserisci numero:\n"

	.text
	.globl main
	.ent main
	
main:
la $a0, msg
li $v0, 4
syscall

li $v0, 5
syscall

move $a0, $v0

subu $sp, $sp, 4
sw $ra, ($sp)

jal sequenzaDiCollatz
move $a0, $v0
li $v0, 1
syscall

lw $ra, ($sp)
addiu $sp, $sp, 4

jr $ra
.end main


sequenzaDiCollatz: 
		subu $sp, $sp, 4
		sw $ra ($sp)
		
		move $s0, $0
		li $s1, 1
		li $s2, 1
		loop: 
			beq $a0, $s1, exit
			addi $s2, $s2, 1
			jal calcolaSuccessivo
			move $a0, $v0
			j loop
		exit:
			move $v0, $s2
			lw $ra, ($sp)
			addiu $sp, $sp, 4
			jr $ra			
.end sequenzaDiCollatz


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