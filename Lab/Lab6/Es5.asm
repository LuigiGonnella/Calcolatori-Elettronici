.data
n=6
k=3


	.text
	.globl main
	.ent main


main:
li $a0, n
li $a1, k
jal combina
move $a0, $v0
li $v0, 1
syscall
li $v0, 10
syscall
.end main


combina: 
		 num: move $t0, $0 #counter decremento
			  move $t1, $a1 #comparatore
			  addi $t2, $0, 1
		      fact_N: beq $t0, $t1, den
					  sub $t3, $a0, $t0
					  addi $t0, $t0, 1
					  mul $t2, $t2, $t3
					  j fact_N
			  
		 den: move $t4, $t2
        	  move $t0, $0 #counter decremento
			  move $t1, $a1 #comparatore
			  addi $t2, $0, 1
		      fact_D: beq $t0, $t1, exit
					  sub $t3, $a1, $t0
					  addi $t0, $t0, 1
					  mul $t2, $t2, $t3
					  j fact_D
		 
		 exit: div $v0, $t4, $t2
			   jr $ra
.end combina
		 
		