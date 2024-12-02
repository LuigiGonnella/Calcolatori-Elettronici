DIM = 64 
 .data 
vetRX: .byte 0x84, 0xFA, 0x09, 0x54, 0x20, 0x42, 0x19, 0x20, 0x41, 0xB1, 0x03 
vetTX: .space DIM 
 .text 
 .globl main 
 .ent main 
main: 
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, vetRX 
	la $a1, vetTX 
	jal SpaceRemove 
    lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
 .end main
 
 
 SpaceRemove: 
	lb $t0, 1($a0)
	lb $t1, 0($a0)
	
	sb $t0, 0($a1)
	sb $t1, 1($a1)

	addi $a1, $a1, 2
	addi $a0, $a0, 2
	
	move $t9, $a1
	loop:
		lb $t0, ($a0)
		beq $t0, 0x03, exit
		beq $t0, 0x20, update
		sb $t0, ($a1)
		addi $a1, $a1, 1
		update: 
			addi $a0, $a0, 1
	j loop
	
	exit:
		sb $t0, ($a1)
		stampa:
			lb $a0, ($t9)
			beq $a0, 0x03, L1
			li $v0, 1
			syscall
			addi $t9, $t9, 1
		j stampa
		
		L1:
			jr $ra
 .end SpaceRemove