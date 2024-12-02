.data
vet: .space 80 #20 word (4 byte)
	.text
	.globl main
	.ent main
dim = 20
main:
move $t0, $0  #valore temporaneo per riempire vettore
move $t1, $0  #indice i
move $t3, $0 #registro per i*4
move $t4, $0 #registro per l'indirizzo corrente dell'elemento=$t2+$t3
move $t5, $0 #registro per l'indirizzo del precedente
addi $t0, $t0, 1 #primo e secondo elemento del vet
move $a0, $t0
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall
move $a0, $t0
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall
la $t2, vet #indirizzo base vet
sw $t0, 0($t2)
addi $t1, $t1, 1
sll $t3, $t1, 2 #i*4
add $t4, $t2, $t3 #indirizzo di vet[i]
sw $t0, 0($t4) #1 in vet[i]

loop: beq $t1, dim, exit #in t0 c'è sempre il precedente, in t5 quello ancora prima
	addi $t5, $t4, -4
	lw $t6, 0($t5) #elemento prima del precedente in t6
	add $t0, $t0, $t6 #nuovo elemento da inserire in t0, sarà il precedente del ciclo successivo
	move $a0, $t0
	li $v0, 1
	syscall
	li $a0, ' '
	li $v0, 11
	syscall
	addi $t1, $t1, 1 #i=i+1
	sll $t3, $t1, 2 #i*4
	add $t4, $t2, $t3 #indirizzo di vet[i]
	sw $t0, 0($t4) #inserisco in vet[i]
	j loop
	
	
exit: li $v0, 10
	  syscall
	  .end main