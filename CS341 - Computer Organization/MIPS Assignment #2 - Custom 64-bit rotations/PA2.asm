# Main author: Nicholas McClellan
# Goal of program: Request two integers from the user, put those 2 integers in registers, combine into a 64-bit register and carryout rotations.
# Got debugging help from: N/A
# Description of what debugging help was received:  None


#Format of the program
#1.Prompt the user to enter an initial integer value for the HI register
#2.Prompt the user to enter an initial integer value for the LO register
#3.Prompt the user to enter the direction of the rotation. You can assume that the user will always enter either 1, -1 or 0:
	#a.If the user enters 1, rotate the 64-bit register left by 1. 
	#Repeat step 3.
	#b.If the user enters -1, rotate the 64-bit register right by 1. 
	#Repeat step 3.
	#c.If  the  user  enters  0, print  the  value  of  HI  and  LO  registers  in  hexadecimal.
	#Terminate the program.
		#i.Hint: Use syscall 34
.text 

main: 

	#Step 1: Ask for and store the HI register value
	la 	$a0, promptHI		#Load the prompt
	li	$v0, 4			#System Call number
	syscall				#Print promptHI to screen
	li	$v0, 5			#System Call number
	syscall				#Get HI register value
	addi 	$t0, $v0, 0		#Move the value from v0 to temp register $t0
	
	#Step 2: Ask for and store the LO register value
	la 	$a0, promptLO		#Load the prompt
	li	$v0, 4			#System Call number
	syscall				#Print promptLO to screen
	li	$v0, 5			#System Call number
	syscall				#Get LO register value
	addi 	$t1, $v0, 0		#Move the value from v0 to temp register $t1

	#Step 3: Ask the user for direction of rotation
	#this will be looped (until the user enters 0?
	loop:
	la	$a0, promptRot		#Load the prompt
	li	$v0, 4			#System Call number
	syscall				#Print promptRot to screen
	li	$v0, 5			#System Call number
	syscall				#Get the user's choice -1, 0, 1
	beq	$v0, $zero, end		#if input == 0, go to end
	bge	$v0, $zero, left	#if input > 0 (1), go to right
	ble	$v0, $zero, right	#if input < 0 (-1), go to left
	
	#Step 3b: If the user enters 1, rotate 64 bits right by 1, jump back to loop
	right:
	andi	$t3, $t0, 1		#store LSB of HI register in $t3
	andi	$t4, $t1, 1		#store LSB of LO register in $t4
	srl	$t0, $t0, 1		#shift by 1 to start rotation and clear LSB
	srl 	$t1, $t1, 1		#shift by 1 to start rotation and clear LSB
	sll 	$t3, $t3, 31		#shift left by 31 to put into correct bit position
	sll 	$t4, $t4, 31		#shift left by 31 to put into correct bit position
	or	$t1, $t1, $t4
	or	$t0, $t0, $t3	
	j loop				#jump back to the input (start of the loop structure)

	#Step 3b: If the user enters -1, rotate 64 bits left by 1, jump back to loop
	left:
	lui	$t7, 0x8000		#store value to get MSB in register $t7 (1000 0000... 0)
	and	$t3, $t0, $t7		#store MSB of HI in register $t3
	and	$t4, $t1, $t7		#store MSB of LO in register $t4
	sll 	$t1, $t1, 1		#shift left 1, clears LSB in prep of bitwise or, and starts rotation
	sll	$t0, $t0, 1		#shift left 1, clears the LSB in prep of bitwise or, and starts rotation
	srl	$t3, $t3, 31		#shift right 31 to put the bit in the correct position to or with the other register
	srl	$t4, $t4, 31		#shift right 31 to put bit in correct posiitipon to or with the other register
	or	$t1, $t1, $t3		#or MSB with shifted register to set LSB
	or	$t0, $t0, $t4		#or MSB with shifted register to set LSB
	j loop				#jump back to the input (start of the loop structure)
	
	#Step 3c: end section that prints the results in hexadecimal. (only reached if the user enters 0 in "loop")
	end:
	#####HI REGISTER
	la	$a0, resultHI		#Load the prompt
	li	$v0, 4			#System Call number
	syscall				#Print resultHI to screen	
	addi	$a0, $t0, 0		#move HI register to $a0 by add by 0
	li	$v0, 34			#System Call number
	syscall				#Prints HI register contents in hex
	
	####newline
	la 	$a0, endl		#Load the prompt
	li	$v0, 4			#System Call number
	syscall				#Print newline
	
	#####LO REGISTER
	la	$a0, resultLO		#Load the prompt
	li	$v0, 4			#System Call number
	syscall				#Print resultLO to screen	
	addi	$a0, $t1, 0		#move LO register to $a0 by add by 0
	li	$v0, 34			#System Call number
	syscall				#Prints LO register contents in hex
			
.data 

endl: .asciiz	"\n" 
promptHI: .asciiz 	"Enter integer value for HI register: "
promptLO: .asciiz 	"Enter integer value for LO register: "
promptRot: .asciiz	"Enter rotation direction (0 to quit): "
resultHI: .asciiz 	"Value of HI: "
resultLO: .asciiz 	"Value of LO: "	
