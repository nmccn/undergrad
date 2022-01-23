# Main author: Nicholas McClellan
# Goal of program: Request two integers from the user, add those integers, and print the result on the screen.
# Got debugging help from: N/A
# Description of what debugging help was received:  None

.text

main:
	#Step 1: Ask the user to enter the first integer
	la 	$a0, msg1		#Load the prompt
	li	$v0, 4			#System Call number
	syscall				#Print msg1 to screen
	#Step 2: Read the integer and save it to a register
	li	$v0, 5			#System Call number
	syscall				#Get number from user
	add	$t0, $v0, $zero		#save integer to register by adding 0
	#Step 3: Ask the user to enter the second number
	la	$a0, msg2		#Load the 2nd prompt
	li	$v0, 4			#System Call number
	syscall				#Print msg2 to screen
	#step 4: Read the integer and save it to a register
	li	$v0, 5			#System Call number
	syscall				#Get number from user
	add	$t1, $v0, $zero		#save integer to register by adding 0
	#Step 5: Add the two integers and save the result to register
	add	$t2, $t1, $t0		#Add the two integers and store in a 3rd register (could use one of the registers to save space)
	#Step 6: Print "Result: " + result
	la	$a0, msg3		#Load the prompt
	li	$v0, 4			#System Call number
	syscall				#Print msg3 to screen
	add	$a0, $t2, $zero		#store the summation in a0 by adding 0
	li	$v0, 1			#System Call number
	syscall				#Printing the summation
	#Step 7: End with a newline.
	la	$a0, endl		#Load the newline
	li	$v0, 4			#System Call number
	syscall				#Print the new line
	
.data 

endl: .asciiz	"\n" 
msg1: .asciiz 	"Enter the first number: "
msg2: .asciiz 	"Enter the second number: "
msg3: .asciiz 	"Result: "
