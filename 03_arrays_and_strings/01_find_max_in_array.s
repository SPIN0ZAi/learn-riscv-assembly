.data
text: .string "The biggest number is: "
vector: .byte 2,5,3,5,2,4,8,0,0,1   
size:   .word 10                

.text
_start:
    lw t0, size     
    addi t0, t0, -1 
    la t1, vector  
    lb t2, 0(t1)   
    
        # Print "string "
    li a7, 4
    la a0, text
    ecall 

loop:
    beqz t0, end_loop  

    addi t1, t1, 1     # Move to next byte in vector
    lb t3, 0(t1)       # Load next element into t3

    bge t2, t3, skip   # If t2 >= t3, skip updating max
    mv t2, t3          # Update max value

skip:
    addi t0, t0, -1 
    j loop         

end_loop:
    
    # Print biggest
    mv a0, t2
    li a7, 1
    ecall

    
    # Exit program
    li a7, 10
    ecall
