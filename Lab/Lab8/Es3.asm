NUM = 5
DIM = NUM * 4
SCONTO = 30
ARROTONDA = 0
.data
msgout: .asciiz "Sconto totale:\n"
prezzi: .word 39, 1880, 2394, 1000, 1590
scontati: .space DIM
	.text
	.globl main
	.ent main
main: 
subu $sp, $sp, 4
sw $ra, 0($sp)

la $a0, prezzi
la $a1, scontati
li $a2, NUM
li $a3, SCONTO
li $t0, ARROTONDA
subu $sp, 4
sw $t0, ($sp)
jal calcola_sconto

move $s0, $v0

lw $t0, 0($sp)
lw $ra, 4($sp)
addiu $sp, $sp, 8


li $a0, '\n'
li $v0, 11
syscall

la $a0, msgout
li $v0, 4
syscall

move $a0, $s0
li $v0, 1
syscall

jr $ra
.end main


calcola_sconto:
		subu $sp, $sp, 8
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		move $v0, $0
		move $t1, $0 #i
		li $t9, 100
		li $t8, 50
		beq $t0, $0, NoArr
		
		Arr:
			beq $t1, $a2, exit
			
			sll $t2, $t1, 2 #i*4
		
			add $s0, $a0, $t2  #indirizzo elemento corrente
		
			lw $t3, ($s0)
			mul $t4, $t3, $a3
			div $t4, $t4, $t9
			
			mfhi $t5
			beq $t5, $0, difetto
			bge $t5, $t8 eccesso
			j difetto
			
			difetto:
				add $v0, $v0, $t4
				sub $t4, $t3, $t4
				add $s1, $a1, $t2
				sw $t4, ($s1)
				addi $t1, $t1, 1
		j Arr
			
			
			
			eccesso:
				addi $t4, $t4, 1
				add $v0, $v0, $t4
				sub $t4, $t3, $t4
				add $s1, $a1, $t2
				sw $t4, ($s1)
				addi $t1, $t1, 1
		j Arr
		
		
		
		
		NoArr:
			beq $t1, $a2, exit
			
			sll $t2, $t1, 2 #i*4
		
			add $s0, $a0, $t2  #indirizzo elemento corrente
		
			lw $t3, ($s0)
			mul $t4, $t3, $a3
			div $t4, $t4, $t9
			
			difetto1:
				add $v0, $v0, $t4
				sub $t4, $t3, $t4
				add $s1, $a1, $t2
				sw $t4, ($s1)
				addi $t1, $t1, 1
		j NoArr
		
		
		exit:
			move $t0, $v0
			lw $s0, 0($sp)
			lw $s1, 4($sp)
			addiu $sp, $sp, 8
			move $t1, $0
			loop: 
				beq $t1, $a2, L1
				lw $a0, ($a1)
				addi $a1, $a1, 4
				li $v0, 1
				syscall
				li $a0, ' '
				li $v0, 11
				syscall
				addi $t1, $t1, 1
			j loop
			
		L1:
			move $v0, $t0
			jr $ra
		
.end calcola_sconto