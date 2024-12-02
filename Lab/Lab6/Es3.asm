.data
msg: .asciiz "ciao\n"	
	.text
	.globl main
	.ent main


main:
la $t0, msg

loop: lb $a0, ($t0)
	  addi $t0, $t0, 1
	  beq $a0, '\n', exit
	  jal UpToLo
	  move $a0, $v0
	  li $v0, 11
	  syscall
	  j loop

UpToLo: addi $v0, $a0, -32
		jr $ra

.end UpToLo
	  

exit:
li $v0, 10
syscall
.end main