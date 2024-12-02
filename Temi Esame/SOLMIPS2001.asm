.data 
vet: .word 15, 64, 1, 2, 4, 5, 9, 1, 294, 52, -4, 5 
 .text 
 .globl main 
 .ent main 
main: 
 subu $sp, $sp, 4 
 sw $ra, 0($sp) 
 
 la $a0, vet # indirizzo di vet 
 li $a1, 12 # dimensione di vet 
 jal monotono 
 
 move $a0, $v0
 li $v0, 1
 syscall
 
 li $a0, ' '
 li $v0, 11
 syscall
 
 move $a0, $v1
 li $v0, 1
 syscall
 
 lw $ra, 0($sp) 
 addiu $sp, $sp, 4 
 jr $ra
 .end main
 
 
 monotono: 
	move $s1, $0
	move $t0, $0
	move $t9, $a0
	li $t8, 1
	move $t6, $0
	move $t5, $0
	loop:
		bge $t0, $a1, exit
		move $s1, $t0
		sll $t4, $t0, 2
		add $a0, $t9, $t4
		
		lw $t1, ($a0)
		addi $a0, $a0, 4
		lw $t3, ($a0)
		
		addi $t0, $t0, 1
		loop1:
			ble $t3, $t1, L1 
			addi $t5, $t5, 1
			addi $t8, $t8, 1
			
			addi $t1, $t3, 0
			
			addi $t0, $t0, 1
			beq $t0, $a1, L1
			sll $t2, $t0, 2
			
			add $a0, $t9, $t2
			
			lw $t3, ($a0)		
		j loop1
		
		L1: 
			blt $t8, $t6, loop
			
			move $t7, $s1
			move $t6, $t8
			
			li $t8, 1
	j loop 
 
 exit:
	move $v0, $t6
	move $v1, $t7
 
	jr $ra
.end monotono