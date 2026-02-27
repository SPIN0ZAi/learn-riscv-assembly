addi t0,zero,7
addi t1,zero,0x14
addi t2,zero,5
addi t3,zero,0x3f





mul s2,t0,t1
mul s1,t2,t3

sub s0,s2,s1


PRINT:
# Print the value in t0
mv a0, s0         # Move the value in t0 to a0 (a0 is the register used for printing the integer)
li a7, 1          # Load the system call number for print integer (1) into a7
ecall             # Perform the system call (prints the integer)

#RETURN
RETURN:

li a7,10
ecall

