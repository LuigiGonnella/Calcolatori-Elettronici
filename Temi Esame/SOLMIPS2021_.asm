N = 3
M = 4
 .data
matriceA: .word 0xAB317811, 0xCD514229, 0xEF832040, 0xA1346269
		  .word 0xB2178309, 0xC3524578, 0x65702887, 0x59227465
		  .word 0x14930352, 0x24157817, 0x39088169, 0x63245986
matriceB: .word 0x39916800, 0x47900160, 0x62270208, 0x87178291
		  .word 0xA7674368, 0xB2092278, 0xC3556874, 0xD6402373
		  .word 0xE1216451, 0x24329020, 0x51090942, 0x11240007
matriceC: .space N * M * 4
 .text
 .globl main
 .ent main
main: subu $sp, $sp, 4
 sw $ra, ($sp)
 la $a0, matriceA
 la $a1, matriceB
 la $a2, matriceC
 li $a3, N
 li $t0, M
 subu $sp, $sp, 4
 sw $t0, ($sp)
 jal MediaMatrice
 lw $ra, ($sp)
 addiu $sp, $sp, 4
 jr $ra
 .end main 
 
 
 MediaMatrice:
	lw $t0, ($sp)
	addiu $sp, $sp, 4
	mul $t9, $a3, $t0
	move $t1, $0
	li $s2, 0x80000000
	li $s3, 0x7FFFFFFF
	
	loop:
		beq $t1, $t9, exit
		sll $t2, $t1, 2
		add $t8, $a0, $t2
		add $t7, $a1, $t2
		add $t6, $a2, $t2
		
		lw $t5, ($t8)
		lw $t4, ($t7)
		
		and $s0, $t5, $s2
		and $s1, $t4, $s2
		
		beq $s0, $s1, L1
		
		add $t3, $t4, $t5
		sra $t3, $t3, 1
		sw $t3, ($t6)
		addi $t1, $t1, 1
		j loop
	
		L1:
			addu  $t3, $t4, $t5
			sra $t3, $t3, 1
			beq $s0, $0, L2
			or $t3, $t3, $s2
			sw $t3, ($t6)
			addi $t1, $t1, 1
			j loop
			L2:
				and $t3, $t3, $s3
				sw $t3, ($t6)
				addi $t1, $t1, 1
 
	j loop
	
	exit:
		move $t6, $t0
		move $t0, $0
		
		stampa:
			beq $t0, $t9, exit1
			
			sll $t1, $t0, 2
			add $t8, $a2, $t1
			lw $a0, ($t8)
			li $v0, 1
			syscall
			
			li $a0, ' '
			li $v0, 11
			syscall
			
			addi $t0, $t0, 1
			div $t0, $t6
			mfhi $t7
			bne $t7, $0, stampa 
			
			li $a0, '\n'
			li $v0, 11
			syscall
	
		j stampa
		
	exit1:
		jr $ra
 
 .end MediaMatrice