.data 
DIMX=8
DIMY=10
matrice: .byte 0, 0, 1, 0, 0, 1, 1, 0, 1, 0 
		 .byte 0, 1, 1, 0, 0, 0, 1, 0, 1, 1 
		 .byte 1, 1, 0, 0, 1, 0, 1, 0, 1, 0 
		 .byte 1, 0, 1, 0, 0, 1, 1, 0, 1, 0 
		 .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 
		 .byte 1, 1, 1, 0, 0, 1, 1, 1, 1, 1 
		 .byte 1, 1, 1, 0, 1, 1, 1, 1, 1, 0 
		 .byte 1, 1, 0, 1, 1, 1, 1, 0, 1, 0

 .text 
 .globl main 
 .ent main 
main: 
subu $sp, $sp, 4
sw $ra, ($sp)

la $a0, matrice
li $a1, DIMX
li $a2, DIMY

subu $sp, $sp, 12
sw $a0, 0($sp)
sw $a1, 4($sp)
sw $a2, 8($sp)

jal valuta1

lw $a0, ($sp)
addiu $sp, $sp, 4

li $v0, 1
syscall

lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra
.end main


valuta1:
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	addiu $sp, $sp, 12
	
	move $t0, $0 #i
	move $t1, $0 #j
	li $t8, 1
	move $t7, $0
	move $t6, $0
	
	
	loop:
		beq $t1, $a2, exit
		add $t9, $a0, $t1
		
	
		loop1:
		
			beq $t0, $a1, L1
			lb $t2, ($t9)
			bne $t2, $t8, L1
			addi $t7, $t7, 1
			add $t9, $t9, $a2
			addi $t0, $t0, 1

		j loop1
		
		L1:
			addi $t1, $t1, 1
			move $t7, $0
			beq $t0, $a1, ok
			move $t0, $0
			
			j loop
	
		ok:
			addi $t6, $t6, 1
			move $t0, $0
	
	j loop



	exit:
		subu $sp, $sp, 4
		sw $t6, 0($sp)
		jr $ra
.end valuta1

