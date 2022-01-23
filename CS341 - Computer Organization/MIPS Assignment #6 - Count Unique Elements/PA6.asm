.data
	prompt: .asciiz	"Enter the number: "
	result: .asciiz "The number of unique digits: "
	
.text

main:
	# s7 = 10, for divisions later
	li	$s7, 10
	# Prompt the user for a number
	la 	$a0, prompt
	li 	$v0, 4
	syscall
	# Retrieve the number
	li 	$v0, 5
	syscall
	# move the number from $v0 -> $s1
	move 	$s1, $v0
	#loop to get each individual digit (using / )
	jal 	while_loop
	
	
while_loop:
	#divide by 10 and get the digit (remainder) and the remaining digits (quotient)
	div	$s1, $s7
	#update the old number and digit found (s1 & a0)
	mflo	$s1
	mfhi	$a0
	jal 	choose_digit
	#exit loop is s1 = 0
	beqz	$s1, summation
	j 	while_loop
	
#Compare the digit a0 to 0-9 and set corresponding flag
choose_digit:
	beq	$a0, 0x0000, dig_0
	beq	$a0, 0x0001, dig_1
	beq	$a0, 0x0002, dig_2
	beq	$a0, 0x0003, dig_3
	beq	$a0, 0x0004, dig_4
	beq	$a0, 0x0005, dig_5
	beq	$a0, 0x0006, dig_6
	beq	$a0, 0x0007, dig_7
	beq	$a0, 0x0008, dig_8
	beq	$a0, 0x0009, dig_9
	
# If a digit is found from the /10 , we set a "counter" = 1. I will use t0-t9 in place of digits 0-9
dig_0:
	addi 	$t0, $0, 1
	jr	$ra
dig_1:
	addi 	$t1, $0, 1
	jr	$ra
dig_2:
	addi 	$t2, $0, 1
	jr	$ra
dig_3:
	addi 	$t3, $0, 1
	jr	$ra
dig_4:
	addi 	$t4, $0, 1
	jr	$ra
dig_5:
	addi 	$t5, $0, 1
	jr	$ra
dig_6:
	addi 	$t6, $0, 1
	jr	$ra
dig_7:
	addi 	$t7, $0, 1
	jr	$ra
dig_8:
	addi 	$t8, $0, 1
	jr	$ra
dig_9:
	addi 	$t9, $0, 1
	jr	$ra

# summation, total number of digits = t0 + t1 + ... + t9
summation:
	add	$v1, $t0, $t1
	add	$v1, $v1, $t2
	add	$v1, $v1, $t3
	add	$v1, $v1, $t4
	add	$v1, $v1, $t5
	add	$v1, $v1, $t6
	add	$v1, $v1, $t7
	add	$v1, $v1, $t8
	add	$v1, $v1, $t9
	# print the result string
	la 	$a0, result
	li 	$v0, 4
	syscall
	# print the # of unique digits
	move 	$a0, $v1
	li 	$v0, 1
	syscall
	# exit
	li 	$v0, 10
	syscall
	