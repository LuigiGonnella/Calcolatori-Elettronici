.data
msg: .asciiz "Inserisci dimensione per triangolo e quadrato:\n"	
	.text
	.globl main
	.ent main


main:
la $a0, msg
li $v0, 4
syscall
li $v0, 5
syscall
move $t2, $v0
move $a0, $t2
jal stampaTriangolo
move $a0, $t2
jal stampaQuadrato
li $v0, 10
syscall
.end main


stampaTriangolo: addi $t3, $a0, 1 #counter 
				 move $t0, $0
				  
				 
counter_tr: li $a0, '*'
			addi $t0, $t0, 1
			beq $t0, $t3, end_tr
			move $t1, $0
			j loop_tr

loop_tr: addi $t1, $t1, 1
	  li $v0, 11
	  syscall
	  bne $t1, $t0, loop_tr
	  li $a0, '\n'
	  li $v0, 11
	  syscall
	  j counter_tr
	  
end_tr: jr $ra
.end stampaTriangolo

stampaQuadrato: addi $t3, $a0, 1 #counter 
				move $t4, $a0
				move $t0, $0
				move $t1, $0
				  
				 
counter_qd: li $a0, '*'
			addi $t0, $t0, 1
			beq $t0, $t3, end_qd
			move $t1, $0
			j loop_qd

loop_qd: addi $t1, $t1, 1
		 li $v0, 11
		 syscall	
	     bne $t1, $t4, loop_qd
	     li $a0, '\n'
	     li $v0, 11
	     syscall
	     j counter_qd
	  
end_qd: jr $ra
.end stampaQuadrato