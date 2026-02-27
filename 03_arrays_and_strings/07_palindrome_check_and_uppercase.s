.data
txt1: .string "Hello World!\n"  # String to convert
txt2: .string "Hello olleH"  # String to convert
op1: .string " Yes, it is a palindrome.\n"
op2: .string " No, it is a palindrome.\n"

.text



main:
    
    la a0, txt2
    li a7, 4
    ecall
    
    call PALIN 
    
    bgez a0,not_pali
    
 # it is a pali  
    la a0,op1
    li a7,4
    ecall
    

    
not_pali:
    la a0,op2
    li a7,4
    ecall
    
   

    # Print the string before modification
    la a0, txt1
    li a7, 4
    ecall

    # Convert to uppercase
    la a0, txt1
    call CAPS

    # Print the string after modification
    la a0, txt1
    li a7, 4
    ecall

    # Exit program
    li a7, 10
    ecall
    
PALIN:
    
    #INPUT ARGUMENTS
    
    # a0: pointer to the string
    
    # OUTPUT RESULT
    
    # a0: (0) false : (1) true
    
    li a0,0
    
    
    
    
    
    ret
    
    

CAPS:
    # a0: pointer to the string
    li t1, 97   # ASCII value of 'a'
    li t2, 123  # ASCII value of 'z' + 1 (to use for range checking)

loop:
    lbu t0, 0(a0)  # Load byte from the string
    beqz t0, end_loop  # Stop if null terminator is reached

    blt t0, t1, skip_it  # If character < 'a', skip
    bge t0, t2, skip_it  # If character > 'z', skip

    # Convert to uppercase
    addi t0, t0, -32
    sb t0, 0(a0)  # Store modified character back

skip_it:
    addi a0, a0, 1  # Move to the next character
    j loop

end_loop:
    ret
