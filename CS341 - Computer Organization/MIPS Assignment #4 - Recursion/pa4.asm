.data
	prompt: .asciiz	"Enter a positive integer: "

	equals: .asciiz " = "
	plus: .asciiz " + "
	
.text

main:
	addi	$s0, $t0, 10		# s1 = 10 (saved for whole prog? effectively constant)
	la	$a0, prompt		#load the prompt
	li	$v0, 4			#print with syscall 4
	syscall				#syscall

	li	$v0, 5			#read in an integer (stored already in a0, ready for function)
	syscall				#sycall
	
	addi	$a1, $v0, 0		#move the value into the a0 register for the function call
	
	jal	funct			#ra is now this point in main

	la	$a0, equals		#load the =
	li	$v0, 4			#print with syscall 4
	syscall				#syscall

	addi	$a0, $v1, 0		#move the value into the a0 register for the function call
	li	$v0, 1			#print the sum with syscall 1
	syscall				#syscall

	li	$v0, 10			#exit thru main with syscall 10
	syscall				#syscall

funct:
	addi 	$sp, $sp, -8		#make room for 2 var
	sw 	$ra, 4($sp)		#save return address ra
	sw 	$a1, 0($sp)		#save the initial value a0
	
	slt	$t0, $a1, $s0		#if n < 10, set t0 = 1, else t0 = 0
	beq	$t0, $zero, recurse	#if n > 10, go to recursive part

	addi	$a0, $a1, 0		#move the number to the a0 reg to be printed
	li	$v0, 1			#print the number with syscall 1
	syscall				#syscall
	
	addi	$v1, $a1, 0		#move the argument to v1 to be returned
	
	addi 	$sp, $sp, 8		#readjust stack pointer (+2)
	jr	$ra			#return to main

recurse:
	div	$a1, $s0		# n / 10 or n % 10 
	mflo	$a1 			# n / 10 (from lo)
	
	jal 	funct			#recursive call (clones first)
	
	la	$a0, plus		#load the +
	li	$v0, 4			#print with syscall 4
	syscall				#syscall

	lw 	$ra 4($sp)		#also restore return address
	lw 	$a1, 0($sp)		#get n from stack
	
	div	$a1, $s0		#n / 10 or n % 10
	mfhi	$t1			# n % 10 (from hi)
	
	addi 	$a0, $t1, 0		#put the number in a0
	li 	$v0, 1			#print the number with syscall 1
	syscall

	addi 	$sp, $sp, 8		#readjust stack pointer (+2)
	add 	$v1, $t1, $v1		#adjust the sum
	jr	$ra			#return to caller





