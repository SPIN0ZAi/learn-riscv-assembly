.data
txt: .string "factorial="
newline: .string "\n"  # Define a newline character

.text
li s0, 5      # Number (factorial input)
li t0, 1      # Factorial result initialized to 1

#print value of input
mv a0, s0
li a7, 1
ecall

# Print newline
li a0, 10      # ASCII code for newline '\n'
li a7, 11      # Syscall to print a character
ecall

# Print "factorial="
la a0, txt
li a7, 4
ecall

# Compute factorial
loop:
    beq s0, zero, end_loop  # Stop when s0 reaches zero
    mul t0, t0, s0          # Multiply result by s0
    addi s0, s0, -1         # Decrement s0
    j loop                  # Repeat

end_loop:
    # Print factorial result
    mv a0, t0
    li a7, 1
    ecall

    # Print newline
    li a0, 10
    li a7, 11
    ecall

    # Exit program
    li a7, 10
    ecall
