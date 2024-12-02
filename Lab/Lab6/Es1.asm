.data
	
	.text
	.globl main
	.ent main


main:
jal stampaTriangolo
jal stampaQuadrato
li $v0, 10
syscall
.end main


stampaTriangolo: move $t0, $0 #counter 
				  
				 
counter_tr: li $a0, '*'
			addi $t0, $t0, 1
			beq $t0, 9, end_tr
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

stampaQuadrato: move $t0, $0 #counter 
				move $t1, $0
				  
				 
counter_qd: li $a0, '*'
			addi $t0, $t0, 1
			beq $t0, 9, end_qd
			move $t1, $0
			j loop_qd

loop_qd: addi $t1, $t1, 1
		 li $v0, 11
		 syscall	
	     bne $t1, 8, loop_qd
	     li $a0, '\n'
	     li $v0, 11
	     syscall
	     j counter_qd
	  
end_qd: jr $ra
.end stampaQuadrato