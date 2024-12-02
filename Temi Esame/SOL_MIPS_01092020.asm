.data
	stringa1: .asciiz "Calcolatori Elettronici 2019/2020"
	stringa2: .asciiz "ALTO o basso?"
.text
 .globl main
 .ent main
 
main: 
 subu $sp, $sp, 4
 sw $ra, ($sp)

 la $a0, stringa1
 la $a1, stringa2
 jal cercaSequenza

 lw $ra, ($sp)
 addiu $sp, $sp, 4
 
 move $a0, $v0
 li $v0, 1
 syscall
 
 jr $ra
 .end main
 
 
 cercaSequenza:
	
	move $t3, $0
	li $t5, 0
	
	loop:
		lb $t0, ($a0)
		lb $t1, ($a1)
		beq $t0, $t5, exit
		beq $t1, $t5, exit
		
		beq $t0, $t1, L1
		addi $t4, $t1, -32
		beq $t0, $t4, L1
		addi $t4, $t1, 32
		beq $t0, $t4, L1
		
		addi $a0, $a0, 1
		j loop
		
		L1:
			addi $t3, $t3, 1
			addi $a0, $a0, 1
			addi $a1, $a1, 1
	j loop
			
			
	
	
	exit:	
		move $v0, $t3
		jr $ra
 .end cercaSequenza