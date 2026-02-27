.data
V1: .byte 0,1,2,3,4,5,6,7,8,9
V2: .byte 56,12,82,4,19
V3: .byte 4,9,15,16,23,42
newline: .asciz "\n"
text1: .asciz "The highest number is "
text2: .asciz " and it is located at position "
text3: .asciz " for V2\n"
text4: .asciz "Sorted V2: "

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
    
    # Sort V2
    la a0, V2
    li a1, 5    # Number of elements in V2
    call sort_vector

    # Print sorted vector
    la a0, V2
    li a1, 5
    call print_vector

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

# Subroutine to sort a vector in descending order
sort_vector:
    beqz a1,end_sort
    
    mv s0,a0   # Save original arguments (address of the vector)
    mv s1,a1   # Number of elements
    mv s2,ra   # Save return address
    
loop3:
    mv a0,s0   # Copy vector
    mv a1,s1
    beqz a1,end_sort   # No remaining vector, exit
    
    call highest_elem
    add a0,a0,s0
    
    # Swap current element with highest element
    lb t0 , 0(s0)  # Load current element        
    lb t1 , 0(a0)  # Load highest element
    sb t1,  0(s0)  # Store highest element in current position
    sb t0,  0(a0)  # Store current element in the highest position
    
    addi s0,s0,1  # Move to the next element
    addi s1,s1,-1 # Decrement counter
    
    j loop3
    
end_sort: 
    mv ra,s2 
    ret

# Subroutine to print the sorted vector
print_vector:
    # Print "Sorted V2: "
    li a7, 4
    la a0, text4
    ecall
    
    mv t0, a0   # Load base address of array
    mv t1, a1   # Number of elements
     mv s2,ra   # Save return address
    li t2, 0    # Counter

print_loop:
    beq t2, t1, print_done  # If all elements printed, exit
    
    lb a0, 0(t0)   # Load element
    li a7, 1
    ecall           # Print number
    
    # Print space
    li a7, 11
    li a0, 32
    ecall
    
    addi t0, t0, 1  # Move to next element
    addi t2, t2, 1  # Increment counter
    j print_loop

print_done:
    # Print newline
    li a7, 4
    la a0, newline
    ecall
    
    ret
