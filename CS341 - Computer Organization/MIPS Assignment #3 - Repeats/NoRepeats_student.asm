.data
	arr: .word 7, 25, 12, -1, 25, 18, 15, -17, 34, 15, 2, 88, 1, -2147483648, 77, 180, 13, 7, 0, 25
	message: .ascii "Non-repeating elements: "
	blankSpace: .ascii " "
.text
#.globl main
main:
	la 	$s0, arr		# base address
	li	$s1, -1			# s1 = i = 0
	li	$s2, -1			# s2 = j = 0
	li 	$s3, 19			# s3 = size = 20
	li	$s4, 1			# s4 = bool isUnique = true

	la	$a0, message		#load message
	li	$v0, 4			#print string syscall#
	syscall				#print string
	j 	outer_loop		#start looping
	
outer_loop:
	addi	$s1, $s1, 1		#i++
	blt	$s3, $s1, exit		#if 19 < i, go to exit
	li	$s2, -1 		#reset j = -1
	j 	inner_loop		#go to nested for loop
	
inner_loop:
	addi	$s2, $s2, 1		#j++
	beq	$s2, $s3, print_num	#if j == size and a duplicate hasn't been found
	
	sll	$t0, $s1, 2		#$t0 = array_index = 4 * i 
	add	$t1, $t0, $s0		#A[0 + i]
	lw	$s5, 0($t1)		#$s5 = A[i]

	sll	$t0, $s2, 2		#$t0 = array_index = 4 * j
	add	$t1, $t0, $s0		#A[0 + j]
	lw	$s6, 0($t1)		#$s6 = A[j]

	beq	$s1, $s2, inner_loop	#if i ==  j , go to the next j value without printing. 
	beq	$s5, $s6, outer_loop	#if A[i] == A[j], go to next i value
	
	j	inner_loop
	
print_num:
	li	$v0, 1			#load print integer
	add	$a0, $s5, $zero		#move the value to be printed to $a0
	syscall				#print the integer
	la	$a0, blankSpace		#print a blankspace to separate the numbers
	li	$v0, 4			#print string #
	syscall				#print the blankspace
	j	outer_loop		#return to the outerloop and keep going
	
exit:
	li 	$v0, 10			#terminate program syscall#
	syscall				#Exit
	 
