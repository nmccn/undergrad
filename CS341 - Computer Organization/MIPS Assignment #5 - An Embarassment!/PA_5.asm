.data
	prompt: .asciiz "Enter 32-bit number to translate to instruction: "
	and_string: .asciiz "and $##, $##, $##"
	or_string: .asciiz "or $##, $##, $##"
	lw_string: .asciiz "lw $##, 0x####($##)"
	sw_string: .asciiz "sw $##, 0x####($##)"
	beq_string: .asciiz "beq $##, $##, "
	jump_string: .asciiz "j "
	unsupported: .asciiz "Unsupported Instruction"
	registers: .asciiz "00atv0v1a0a1a2a3t0t1t2t3t4t5t6t7s0s1s2s3s4s5s6s7t8t9k0k1gpspfpra"
	hex: .asciiz "0123456789abcdef"
	pc_plus4 : .word 0x40000000
	pcplus4  : .word 0x4000C008
	lw_op : .word 0x00000023
	sw_op : .word 0x0000002b
	beq_op: .word 0x00000004
	j_op  :	.word 0x00000002
	AND_funct : .word 0x00000024
	OR_funct  : .word 0x00000025
	##this has to be absolute terrible programming but j YOLO
	reg0 : .word 0x00000000
	reg1 : .word 0x00000001
	reg2 : .word 0x00000002
	reg3 : .word 0x00000003
	reg4 : .word 0x00000004
	reg5 : .word 0x00000005
	reg6 : .word 0x00000006
	reg7 : .word 0x00000007
	reg8 : .word 0x00000008
	reg9 : .word 0x00000009
	reg10 : .word 0x0000000A
	reg11 : .word 0x0000000B
	reg12 : .word 0x0000000C
	reg13 : .word 0x0000000D
	reg14 : .word 0x0000000E
	reg15 : .word 0x0000000F
	reg16 : .word 0x00000010
	reg17 : .word 0x00000011
	reg18 : .word 0x00000012
	reg19 : .word 0x00000013
	reg20 : .word 0x00000014
	reg21 : .word 0x00000015
	reg22 : .word 0x00000016
	reg23 : .word 0x00000017
	reg24 : .word 0x00000018
	reg25 : .word 0x00000019
	reg26 : .word 0x0000001A
	reg27 : .word 0x0000001B
	reg28 : .word 0x0000001C
	reg29 : .word 0x0000001D
	reg30 : .word 0x0000001E
	reg31 : .word 0x0000001F

.text

.globl main
main:
	#load the registers araray in s0 
	la	$s0, registers
	# This code block prompts and receives the user input for the instruction (32-bit 2s comp)
	#prompt the user for a number
	la	$a0, prompt		#get the prompt into register
	li	$v0, 4			#print the string
	syscall
	#actually retrieve said number
	li	$v0, 5			#get input integer
	syscall
	move	$s7, $v0		#the integer (v0) -> s7
	#This code block will determine which type of instruction based on the opcode
	#gets the opcode from the input number
	srl 	$s6, $s7, 26		#get the upper 6 bits (opcode)
	beq 	$s6, $zero, r_type	#if opcode extracted matches the opcode for r type (0) -> we will need to determine using funct
	#load in the opcodes we are told to include
	lw	$t0, lw_op		#t0 = lw_op
	lw	$t1, sw_op		#t1 = sw_op
	lw	$t2, beq_op		#t2 = beq_op
	lw	$t3, j_op		#t3 = j_op
	#branch logic to bring us to the correct instruction
	beq 	$s6, $t0, lw_instr	#if opcode is same as lw -> go there
	beq 	$s6, $t1, sw_instr	#if opcode is same as sw -> go there
	beq 	$s6, $t2, beq_instr	#if opcode is same as beq-> go there
	beq 	$s6, $t3, j_instr	#if opcode is same as j  -> go there
	j	no_instr		#if the opcode is not supported

r_type:	
	#Needs aditional logic, as all R-type use the 0 opcode.
	#Get the funct code from the original input, and decide from that
	sll 	$s6, $s7, 26		#get 5 LSB
	srl 	$s6, $s6, 26		#put them in the right spot
	lw	$t0, AND_funct		#get  and funct code into  t0
	lw	$t1, OR_funct		#same thing with or into t1
	beq	$s6, $t1, OR_instr	#if funct is 25 -> OR
	beq	$s6, $t0, AND_instr	#if funct is 24  -> AND
	
AND_instr:
	la 	$a0, and_string		# unnecessary, since $a0 already holds the proper address, but anyway.
	#populate rs, rd  rt
	sll	$s7, $s7, 6		#get rid of the op code (we dealt with it already)
	srl	$s7, $s7, 17		#get rid of the funct + shamt as they are not important in either of the instructions strings
	#now we have a bunch of zeroes leading up to rs rt rd, and we want to do the same thing, but on the 3 diff fields. so we will store them a0-a2
	srl	$a1, $s7, 10		#gets a1 = rs
	jal 	pick_a_reg		#go pick a reg with a0
	ush 	$v0, 10($a0)		# storing reg into string
	srl	$a1, $s7, 5		#get rid of rd
	sll	$a1, $a1, 27		#get rid of rs 
	srl	$a1, $a1, 27		#gets a1 = rt
	jal	pick_a_reg		#go pick  a reg with a0
	ush	$v0, 15($a0)		# storing reg into string
	sll	$a1, $s7, 27		#get rid of rs & rt
	srl	$a1, $a1, 27		#gets a2 = rd
	jal	pick_a_reg		#go and pick another reg
	ush	$v0, 5($a0)		# storing reg into string
	#print the final string & exit
	li 	$v0, 4			# print our modified string
	syscall
	li 	$v0, 10			# exit
	syscall	

OR_instr:
	la	$a0, or_string
	#populate rs, rd  rt
	sll	$s7, $s7, 6		#get rid of the op code (we dealt with it already)
	srl	$s7, $s7, 17		#get rid of the funct + shamt as they are not important in either of the instructions strings
	#now we have a bunch of zeroes leading up to rs rt rd, and we want to do the same thing, but on the 3 diff fields. so we will store them a0-a2
	srl	$a1, $s7, 10		#gets a1 = rs
	jal 	pick_a_reg		#go pick a reg with a0
	ush 	$v0, 9($a0)		# storing reg into string
	srl	$a1, $s7, 5		#get rid of rd
	sll	$a1, $a1, 27		#get rid of rs 
	srl	$a1, $a1, 27		#gets a1 = rt
	jal	pick_a_reg		#go pick  a reg with a0
	ush	$v0, 14($a0)		# storing reg into string
	sll	$a1, $s7, 27		#get rid of rs & rt
	srl	$a1, $a1, 27		#gets a2 = rd
	jal	pick_a_reg		#go and pick another reg
	ush	$v0, 4($a0)		# storing reg into string
	li 	$v0, 4			# print our modified string
	syscall
	li 	$v0, 10			# exit
	syscall
	
lw_instr:
	la	$a0, lw_string		#load in the string
	la 	$t0, registers		#Load the register name string
	move 	$a1, $a0
	move	$a2, $a0
	#populate rs, rd, rt
	#get rt
	sll	$a1, $s7, 11
	srl	$a1, $a1, 27
	jal 	pick_a_reg		#go pick a reg with a0
	ush 	$v0, 4($a0)		# storing reg into string
	#get rs
	srl 	$a1, $s7, 21
	sll	$a1, $a1, 27
	srl	$a1, $a1, 27
	jal 	pick_a_reg		# go pick a reg with a0
	ush 	$v0, 16($a0)		# storing reg into string
	
	move	$a1, $s7		#reset a1

	#Get hex value
	la	$t0, hex		#load the hex register
	#Getting MSB for the offset
	sll	$a1, $s7, 16
	srl	$a1, $a1, 28		#clears the number to be only the immediate (MSB)
	add	$t7, $a1, $t0		#offset for hex mapping
	lbu	$t7, 0($t7)		#accessing the mapped hex value
	sb	$t7, 10($a0)
	#Getting next byte for the offset
	sll	$a1, $s7, 20
	srl	$a1, $a1, 28		#clears the number to be only the immediate (MSB)
	add	$t7, $a1, $t0		#offset for hex mapping
	lbu	$t7, 0($t7)		#accessing the mapped hex value
	sb	$t7, 11($a0)
	#Getting next byte for the offset
	sll	$a1, $s7, 24
	srl	$a1, $a1, 28		#clears the number to be only the immediate (MSB)
	add	$t7, $a1, $t0		#offset for hex mapping
	lbu	$t7, 0($t7)		#accessing the mapped hex value
	sb	$t7, 12($a0)	
	#Getting LSB for the offset
	sll	$a1, $s7, 28
	srl	$a1, $a1, 28		#clears the number to be only the immediate (MSB)
	add	$t7, $a1, $t0		#offset for hex mapping
	lbu	$t7, 0($t7)		#accessing the mapped hex value
	sb	$t7, 13($a0)
	#End
	li 	$v0, 4			# print our modified string
	la 	$a0, lw_string		# unnecessary, since $a0 already holds the proper address, but anyway.
	syscall
	li 	$v0, 10			# exit
	syscall
sw_instr:
	la 	$t0, registers		#Load the register name string
	la	$a0, sw_string		#load in the string
	#populate rs, rd  rt
	#get rt
	sll	$a1, $s7, 11
	srl	$a1, $a1, 27
	jal 	pick_a_reg		#go pick a reg with a0
	ush 	$v0, 4($a0)		# storing reg into string
	#get rs
	srl 	$a1, $s7, 21
	sll	$a1, $a1, 27
	srl	$a1, $a1, 27
	jal 	pick_a_reg		#go pick a reg with a0
	ush 	$v0, 16($a0)		# storing reg into string
	#load hex string
	la 	$a1, hex		#Load the hex number string
	#Match the immediate value number with the hex number in the hex string; Getting the MSB
	sll 	$s0, $s7, 16
	srl 	$s0, $s0, 28		#Isolate byte
	add 	$t7, $a1, $s0		#Offset for hex string
	lbu 	$t7, 0($t7)		#Val in hex string
	sb 	$t7, 10($a0)		#hex val in my string
	#Getting next byte
	sll 	$s0, $s7, 20
	srl 	$s0, $s0, 28		#Isolate byte
	add 	$t7, $a1, $s0		#Offset for hex string
	lbu 	$t7, 0($t7)		#Val in hex string
	sb 	$t7, 11($a0)		#hex val in my string
	#Getting next byte
	sll 	$s0, $s7, 24
	srl 	$s0, $s0, 28		#Isolate byte
	add 	$t7, $a1, $s0		#Offset for hex string
	lbu 	$t7, 0($t7)		#Val in hex string
	sb 	$t7, 12($a0)		#hex val in my string
	#Getting LSB
	sll 	$s0, $s7, 28
	srl 	$s0, $s0, 28		#Isolate byte
	add 	$t7, $a1, $s0		#Offset for hex string
	lbu 	$t7, 0($t7)		#Val in hex string
	sb 	$t7, 13($a0)		#hex val in my string
		
	
	li 	$v0, 4			# print our modified string
	la 	$a0, sw_string		# unnecessary, since $a0 already holds the proper address, but anyway.
	syscall
	li 	$v0, 10			# exit
	syscall
beq_instr:
	la	$a0, beq_string		#load in the string
	#calculate the immediate
	#populate and calculate the immediate for beq
	sll 	$s6, $s7, 16		#get the 16 LSB
	sra 	$s6, $s6, 16		#get them back into the LSB position
	sll	$s6, $s6, 2		#multiply by 4
	lw	$t0, pcplus4		#get the upper 4 bits from the given address
	add	$s6, $s6, $t0		#add to PC + 4
	move	$t7, $s6		#save the immediate 
	#get rt
	sll	$a1, $s7, 11
	srl	$a1, $a1, 27
	jal 	pick_a_reg		#go pick a reg with a0
	ush 	$v0, 10($a0)		# storing reg into string
	#get rs
	srl 	$a1, $s7, 21
	sll	$a1, $a1, 27
	srl	$a1, $a1, 27
	jal 	pick_a_reg		#go pick a reg with a0
	ush 	$v0, 5($a0)		# storing reg into string
	#Prints the modified beq string
	li 	$v0, 4			# print our modified string
	syscall
	#Prints the branch target address
	li	$v0, 34			#print immediate as hex value
	move	$a0, $t7		#move into argument
	syscall
	#Exit
	li 	$v0, 10			# exit
	syscall
j_instr:
	#print the start of the line ("j ")
	li 	$v0, 4			# print our modified string
	la 	$a0, jump_string	# unnecessary, since $a0 already holds the proper address, but anyway.
	syscall
	#calculate and print the address
	sll 	$s6, $s7, 6		#get the lower 26 bits, the address
	srl	$s6, $s6, 6		#place them back where they belong
	lw	$t0, pc_plus4		#get the upper 4 bits from the given address
	sll	$s6, $s6, 2		#add the 2 0s
	add	$s6, $s6, $t0		#combine the upper 4 + middle 26
	li	$v0, 34			#print as hex value
	move	$a0, $s6		#move into argument
	syscall
	#exit
	li 	$v0, 10			# exit
	syscall
	
no_instr:
	li 	$v0, 4			# print our modified string
	la 	$a0, unsupported	# unnecessary, since $a0 already holds the proper address, but anyway.
	syscall
	li 	$v0, 10			# exit
	syscall
	
pick_a_hex:
	#print the whole hex val
	la	$t0, hex		#Load the hex number string
	srl	$a2, $a1, 12
	add	$t1, $a1, $a2
	lbu	$a2, 0($t1)
	sb	$a2, 10($a0)
	jr	$ra

pick_a_reg:
	lw	$t0, reg2		# v0
	lw	$t1, reg13		# t5
	lw	$t2, reg18		# s2
	lw	$t3, reg19		# s3
	lw	$t4, reg6		# a2
	lw	$t5, reg0		# 00
	beq	$a1, $t0, v0
	beq	$a1, $t1, t5
	beq	$a1, $t2, s2
	beq	$a1, $t3, s3
	beq	$a1, $t4, a2
	beq	$a1, $t5, zero_reg
	lw	$t0, reg1		# v0
	lw	$t1, reg3		# t5
	lw	$t2, reg4		# s2
	lw	$t3, reg5		# s3
	lw	$t4, reg7		# a2
	lw	$t5, reg8		# 00
	beq	$a1, $t0, at_reg
	beq	$a1, $t1, v1
	beq	$a1, $t2, a0
	beq	$a1, $t3, a1
	beq	$a1, $t4, a3
	beq	$a1, $t5, t0
	lw	$t0, reg9		# v0
	lw	$t1, reg10		# t5
	lw	$t2, reg11		# s2
	lw	$t3, reg12		# s3
	lw	$t4, reg14		# a2
	lw	$t5, reg15		# 00
	beq	$a1, $t0, t1
	beq	$a1, $t1, t2
	beq	$a1, $t2, t3
	beq	$a1, $t3, t4
	beq	$a1, $t4, t6
	beq	$a1, $t5, t7
	lw	$t0, reg16		# v0
	lw	$t1, reg17		# t5
	lw	$t2, reg20		# s2
	lw	$t3, reg21		# s3
	lw	$t4, reg22		# a2
	lw	$t5, reg23		# 00
	beq	$a1, $t0, s0
	beq	$a1, $t1, s1
	beq	$a1, $t2, s4
	beq	$a1, $t3, s5
	beq	$a1, $t4, s6
	beq	$a1, $t5, s7
	lw	$t0, reg24		# v0
	lw	$t1, reg25		# t5
	lw	$t2, reg26		# s2
	lw	$t3, reg27		# s3
	lw	$t4, reg28		# a2
	lw	$t5, reg29		# 00
	beq	$a1, $t0, t8
	beq	$a1, $t1, t9
	beq	$a1, $t2, k0
	beq	$a1, $t3, k1
	beq	$a1, $t4, gp
	beq	$a1, $t5, sp
	lw	$t4, reg30		# a2
	lw	$t5, reg31		# 00
	beq	$a1, $t4, fp
	beq	$a1, $t5, ra
	jr	$ra
	
	
zero_reg:
	ulhu 	$v0, 0($s0)		# loading "00" from registers character array. It is stored at indexes 0  and  1
	jr	$ra
at_reg:
	ulhu 	$v0, 2($s0)		# loading "at" from registers character array. It is stored at indexes 2  and  3
	jr	$ra
v0:
	ulhu 	$v0, 4($s0)		# loading "v0" from registers character array. It is stored at indexes 4  and  5
	jr	$ra
v1:
	ulhu 	$v0, 6($s0)		# loading "v1" from registers character array. It is stored at indexes 6  and  7
	jr	$ra
a0:
	ulhu 	$v0, 8($s0)		# loading "a0" from registers character array. It is stored at indexes 8  and  9
	jr	$ra
a1:
	ulhu 	$v0, 10($s0)		# loading "a1" from registers character array. It is stored at indexes 10  and 11
	jr	$ra
a2:
	ulhu 	$v0, 12($s0)		# loading "a2" from registers character array. It is stored at indexes 12  and  13
	jr	$ra
a3:
	ulhu 	$v0, 14($s0)		# loading "a3" from registers character array. It is stored at indexes 14 and  15
	jr	$ra
t0:
	ulhu 	$v0, 16($s0)		# loading "t0" from registers character array. It is stored at indexes 16  and  17
	jr	$ra
t1:
	ulhu 	$v0, 18($s0)		# loading "t1" from registers character array. It is stored at indexes 18  and  19
	jr	$ra
t2:
	ulhu 	$v0, 20($s0)		# loading "t2" from registers character array. It is stored at indexes 20  and  21
	jr	$ra
t3:
	ulhu 	$v0, 22($s0)		# loading "t3" from registers character array. It is stored at indexes 22  and  23
	jr	$ra
t4:
	ulhu 	$v0, 24($s0)		# loading "t4" from registers character array. It is stored at indexes 24  and  25
	jr	$ra
t5:
	ulhu 	$v0, 26($s0)		# loading "t5" from registers character array. It is stored at indexes 26  and  27
	jr	$ra
t6:
	ulhu 	$v0, 28($s0)		# loading "t6" from registers character array. It is stored at indexes 28  and  29
	jr	$ra
t7:
	ulhu 	$v0, 30($s0)		# loading "t7" from registers character array. It is stored at indexes 30  and  31
	jr	$ra
s0:
	ulhu 	$v0, 32($s0)		# loading "s0" from registers character array. It is stored at indexes 32  and  33
	jr	$ra
s1:
	ulhu 	$v0, 34($s0)		# loading "s1" from registers character array. It is stored at indexes 34  and  35
	jr	$ra
s2:
	ulhu 	$v0, 36($s0)		# loading "s2" from registers character array. It is stored at indexes 36  and  37
	jr	$ra
s3:
	ulhu 	$v0, 38($s0)		# loading "s3" from registers character array. It is stored at indexes 38  and  39
	jr	$ra
s4:
	ulhu 	$v0, 40($s0)		# loading "s4" from registers character array. It is stored at indexes 40  and 41
	jr	$ra
s5:
	ulhu 	$v0, 42($s0)		# loading "s5" from registers character array. It is stored at indexes 42  and 43
	jr	$ra
s6:
	ulhu 	$v0, 44($s0)		# loading "s6" from registers character array. It is stored at indexes 44  and 45
	jr	$ra
s7:
	ulhu 	$v0, 46($s0)		# loading "s7" from registers character array. It is stored at indexes 46  and 47
	jr	$ra
t8:
	ulhu 	$v0, 48($s0)		# loading "t8" from registers character array. It is stored at indexes 48 and  49
	jr	$ra
t9:
	ulhu 	$v0, 50($s0)		# loading "t9" from registers character array. It is stored at indexes 50  and  51
	jr	$ra
k0:
	ulhu 	$v0, 52($s0)		# loading "k0" from registers character array. It is stored at indexes 52  and  53
	jr	$ra
k1:
	ulhu 	$v0, 54($s0)		# loading "k1" from registers character array. It is stored at indexes 54  and  55
	jr	$ra
gp:
	ulhu 	$v0, 56($s0)		# loading "gp" from registers character array. It is stored at indexes 56  and  57
	jr	$ra
sp:
	ulhu 	$v0, 58($s0)		# loading "sp" from registers character array. It is stored at indexes 58  and  59
	jr	$ra
fp:
	ulhu 	$v0, 60($s0)		# loading "fp" from registers character array. It is stored at indexes 60  and  61
	jr	$ra
ra:
	ulhu 	$v0, 62($s0)		# loading "ra" from registers character array. It is stored at indexes 62  and 63
	jr	$ra

	
	
	
	
