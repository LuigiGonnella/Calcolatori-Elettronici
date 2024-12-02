DIM = 8 
.data 
matrice: .byte 3, 1, 41, 5, 9, 26, 5, 35 
		 .byte 89, 79, 32, 3, 8, 46, 26, 4 
		 .byte 33, 8, 32, 79, 50, 28, 8, 4 
		 .byte 19, 71, 69, 39, 9, 37, 5, 10 
		 .byte 58, 20, 9, 74, 9, 44, 59, 2 
		 .byte 30, 7, 8, 16, 40, 6, 28, 6 
		 .byte 20, 8, 9, 98, 62, 80, 3, 48 
		 .byte 25, 34, 21, 1, 70, 6, 7, 9 
	.text 
	.globl main 
	.ent main 
main: 

subu $sp, $sp, 4 
sw $ra, ($sp) 

la $a0, matrice 
li $a1, 7
li $a2, DIM 
jal maxInTriangolo 

move $a0, $v0
li $v0, 1
syscall

lw $ra, ($sp) 
addiu $sp, $sp, 4
jr $ra 
.end main


maxInTriangolo:
	move $t0, $0
	addi $t2, $a1, 0
	sll $t1, $a1, 3
	add $s0, $a0, $t1 
	add $s0, $s0, $a1 
	lb $t9, ($s0)
	move $t3, $s0
	
	loop:
		beq $t0, $t2, L1
		addi $t3, $t3, -8
		
		lb $s1, ($t3)
		
		bgt $s1, $t9, max 
		addi $t0, $t0, 1
		
		j loop
		max:
			move $t9, $s1
			addi $t0, $t0, 1
	j loop
	
	L1:
	move $t0, $0
	move $t3, $s0
	
	loop1:
		beq $t0, $t2, L2
		addi $t3, $t3, -1
		
		lb $s1, ($t3)
		
		bgt $s1, $t9, max1
		addi $t0, $t0, 1
		j loop1
		
		max1:
			move $t9, $s1
			addi $t0, $t0, 1
	j loop1
	
	
	L2:
	move $t0, $0
	sub $t3, $s0, $a1
	addi $t8, $a1, -1
	
	loop2:
		beq $t0, $t8, exit
		addi $t3, $t3, -7
		
		lb $s1, ($t3)
		
		bgt $s1, $t9, max2
		addi $t0, $t0, 1
		j loop2
		
		max2:
			move $t9, $s1
			addi $t0, $t0, 1
	j loop2
	
	exit:
		move $v0, $t9
		jr $ra
.end maxInTriangolo