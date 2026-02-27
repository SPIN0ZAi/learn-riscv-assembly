.data
V1: .byte 0,1,2,3,4,5,6,7,8,9
V2: .byte 56,12,82,4,19
V3: .byte 4,9,15,16,23,42
newline: .asciz "\n"
text1: .asciz "The highest number is "
text2: .asciz " and it is located at position "
text3: .asciz " for V2\n"

.text
.globl main

main:
    # Load V2
    la a0, V2
    li a1, 5    # Number of elements in V2
    call highest_elem

    mv t5, a0   # Save highest position
    mv t6, a1   # Save highest value

    # Print "The highest number is "
    li a7, 4
    la a0, text1
    ecall

    # Print highest number
    li a7, 1
    mv a0, t6
    ecall

    # Print " and it is located at position "
    li a7, 4
    la a0, text2
    ecall

    # Print highest number position
    li a7, 1
    mv a0, t5
    ecall

    # Print " for V2\n"
    li a7, 4
    la a0, text3
    ecall

    # Exit
    li a7, 10
    ecall

# Function to find highest element and its index
highest_elem:
    mv t0, a0       # Load base address of array
    li t1, 0        # Index of highest element
    lb t2, 0(t0)    # Load first element as highest
    li t3, 0        # Current index counter
    mv t4, a1       # Store length in t4

loop2:
    addi t3, t3, 1  # Increment index
    addi t0, t0, 1  # Move to next element
    lb t5, 0(t0)    # Load new element

    ble t4, t3, end # If we checked all elements, exit

    bge t2, t5, loop2 # If new element is smaller, continue

    mv t2, t5       # Update highest value
    mv t1, t3       # Update highest index

    j loop2

end:
    mv a0, t1       # Return highest position
    mv a1, t2       # Return highest value
    ret
