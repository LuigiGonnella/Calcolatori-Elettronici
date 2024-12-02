.data
var1: .word 200
var2: .word 150
var3: .word 90
	.text
	.globl main
	.ent main 
main:
	lw $t1, var1
	lw $t2, var2
	lw $t3, var3
	move $a0,$t1 
	move $a1,$t2
	ble $t1, $t2, L1
	move $t0, $a0
	move $a0, $a1
	move $a1, $t0
	move $t1, $a0
	move $t2, $a1
	L1: move $a0,$t1
	move $a1,$t3
	ble $t1, $t3, L2
	move $t0, $a0
	move $a0, $a1
	move $a1, $t0
	move $t1, $a0
	move $t3, $a1
	L2: move $a0,$t2 
	move $a1,$t3
	ble $t2, $t3, L3
	move $t0, $a0
	move $a0, $a1
	move $a1, $t0
	move $t2, $a0
	move $t3, $a1
	L3: move $a0, $t1
	li $v0, 1
	syscall 
	move $a0, $t2
	li $v0, 1
	syscall 
	move $a0, $t3
	li $v0, 1
	syscall 
	li $v0, 10
	syscall
	.end main