.data
	prompt: .asciiz "Enter the input for Hexman: "
	promptError: .asciiz "Invalid Hexman input! \n"
	hexmanStart: .asciiz "Starting Hexman with: "
	getNumber: .asciiz "\nEnter decimal in range [A,F] hex: "
	numberError: .asciiz "Number is not in range!"
	gameState1: .asciiz  "Hexstring: "
	gameState2: .asciiz " Lives remaining: "
	playerWin: .asciiz "\nYou won!"
	playerLose: .asciiz "\nYou lost!"
	
.text
# I am going to try to break the program into parts, as shown in the assignment handout.

# Part 1: User enters the guessed word, by signed integer
Part1:
	# Prompt the user for the number
	la	$a0, prompt			# Load prompt
	li	$v0, 4				# 4 = print str
	syscall
	# Retrieve the number
	li	$v0, 5				# 5 = get int
	syscall
	# Move the input integer into s0
	move	$s0, $v0			# move the number stored in v0
	# Init register to 0, for the word to be displayed. 
	li	$s7, 0				# s7 = 0x00000000 (blank str)
	# Counter to use to loop, amount of char = 8
	j	Part2				# move to part2 unconditionally (could have just tacked it onto part1 i suppose)

# Part 2: The game checks whether the users input is only A-F
Part2:
	#Check that the number is >= 0xAAAA AAAA
	blt	$s0, 0xAAAAAAAA, Part2Error	# If the number is less than all A, jump to print the error message
	bgt	$s0, 0xFFFFFFFF, Part2Error	# If the number is greater than all F, jump to print the error message'
	j	Part3				# Otherwise, we will go on to Part3

# This simply prints the error and returns to Part1.
Part2Error:
	#Load and print the error message
	la	$a0, promptError		# Load the error string
	li	$v0, 4				# 4 = print str
	syscall
	j	Part1				# We jump back to part1 after giving user error
	
# Part 3: The game prints the user's input in 2's complement hex to show what word to guess, lives also set to 3
Part3:
	#Print the string for starting the game
	la	$a0, hexmanStart		# Load the start string
	li	$v0, 4				# 4 = print str
	syscall
	#Print the value stored in s0
	move	$a0, $s0			# Move the value in s0 to a0 to print
	li	$v0, 34				# 34 = print hex
	syscall
	#Set lives to 3				# s1 = lives
	li	$s1, 3				# s1 = 3
	j 	Part4				# We move onto part 4 always

# Part 4: The game checks whether the user has lives remaining
Part4:
	beq 	$s1, 0, Part4Lost		# If lives == 0, go to the procedure to print lose + exit
	j	Part5				# Otherwise, we carry on to part 5

# Simply prints lose message and exits the program	
Part4Lost:
	#Load/Print string and then Exit
	la	$a0, playerLose			# load the lose string
	li	$v0, 4				# 4 = print str
	syscall
	li	$v0, 10				# 10 = exit
	syscall

# Part 5: user is prompted t oguess a letter by entering a number
Part5:
	#Load/Print the prompt for a guess
	la	$a0, getNumber			# load the prompt for guess
	li	$v0, 4				# 4 = print str
	syscall
	#Read in a guess
	li	$v0, 5				# retrieve a guess
	syscall
	#Move guess to s2
	move	$s2, $v0
	#Validate the guess
	blt	$s2, 0x0000000A, Part5Error	#if guess < A, loop around
	bgt	$s2, 0x0000000F, Part5Error	#if guess > F, loop around
	j	Part6				# otherwise, continue to step 6
	
# Simply prints error for being out of range and then loops back around
Part5Error:
	#Load/Print the error message
	la	$a0, numberError		# load the guess range error
	li	$v0, 4				# 4 = print str
	syscall	
	#loop it back aroundddddddddddddddddddd
	j 	Part5				# loop back to Part5

# Part 6: After getting a guess, the game prints 32-bit hex with 0 for blanks and the letter (if correct) filled in, or decrement life (if incorrect)
Part6:
	# Process the guess & update s7
	
	jal 	processGuess			# process the guess in separate procedure
	# Print the gamestate with updated string
	la	$a0, gameState1			# Load the beginning of the gamestate print statement
	li	$v0, 4				# 4 = print str
	syscall			
	move	$a0, $s7			# Load the current displayed word
	li	$v0, 34				# 4 = print str
	syscall
	j	Part7				# go to part 7 no matter what
	
# Going to just use a flag and check all 8 spots.
processGuess:
	li	$t0, 0
	# Get a copy of the answer
	move	$s3, $s0
	bit1:
	# LSB
	andi	$t9, $s3, 15
	beq	$t9, $s2, write1
	bit2:
	#LSB +1
	srl	$s3, $s3, 4
	andi	$t9, $s3, 15
	beq	$t9, $s2, write2
	bit3:
	srl	$s3, $s3, 4
	andi	$t9, $s3, 15
	beq	$t9, $s2, write3	
	bit4:
	srl	$s3, $s3, 4
	andi	$t9, $s3, 15
	beq	$t9, $s2, write4	
	bit5:
	srl	$s3, $s3, 4
	andi	$t9, $s3, 15
	beq	$t9, $s2, write5
	bit6:
	srl	$s3, $s3, 4
	andi	$t9, $s3, 15
	beq	$t9, $s2, write6
	bit7:
	srl	$s3, $s3, 4
	andi	$t9, $s3, 15
	beq	$t9, $s2, write7
	bit8:
	srl	$s3, $s3, 4
	andi	$t9, $s3, 15
	beq	$t9, $s2, write8
	checkFlag:
	bne	$t0, 1, loseLife
	jr	$ra
	
# Part 7: Print the number of lives the user has
Part7:
	#Load/Print the number of lives the user has remaining
	# String portion
	la	$a0, gameState2			# Load the second half of the gamestate print statement
	li	$v0, 4				# 4 = print str
	syscall
	# Amount of lives
	move	$a0, $s1			# load the number of lives (s7) into a0
	li	$v0, 1				# 1 = print int
	syscall
	j	Part8				# go to part8 no matter what

# Part 8: Checks whether all letters ofo the word were guessed correctly
Part8:
	# Has the user won yet?
	beq	$s0, $s7, Part8Won		# If the letters are all guessed, the user won
	j	Part4				# otherwise, we go to step 4
	
# Simply prints the winning message and exits the game
Part8Won:
	#Load/Print Won message
	la	$a0, playerWin			# load the winning message
	li	$v0, 4				# 4 = print str
	syscall
	#Exit
	li	$v0, 10				# 10 = exit
	syscall

write1:
	or	$s7, $s7, $t9
	li	$t0, 1
	j	bit2
write2:
	sll	$t9, $t9, 4
	or	$s7, $s7, $t9
	li	$t0, 1
	j	bit3
write3:
	sll	$t9, $t9, 8
	or	$s7, $s7, $t9
	li	$t0, 1
	j	bit4
write4:
	sll	$t9, $t9, 12
	or	$s7, $s7, $t9
	li	$t0, 1
	j	bit5
write5:
	sll	$t9, $t9, 16
	or	$s7, $s7, $t9
	li	$t0, 1
	j	bit6
write6:
	sll	$t9, $t9, 20
	or	$s7, $s7, $t9
	li	$t0, 1
	j	bit7
write7:
	sll	$t9, $t9, 24
	or	$s7, $s7, $t9
	li	$t0, 1
	j	bit8
write8:
	sll	$t9, $t9, 28
	or	$s7, $s7, $t9
	li	$t0, 1
	j	checkFlag
	
loseLife:
	addi	$s1, $s1, -1
	jr	$ra

