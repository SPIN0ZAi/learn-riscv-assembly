.data
space:      .string ", "   # Space and comma separator
liftoff:    .string "Liftoff!\n"
tminus:     .string "T-minus "

.text
addi s0,s0,1

_start:
    # Print "T-minus "
    li a7, 4
    la a0, tminus
    ecall

    # Initialize countdown value
    li t1, 10

loop:
    # Print number
    mv a0, t1
    li a7, 1
    ecall

    # If t1 is zero, print "Liftoff!" and exit
    beq t1, s0, liftoff_label

    # Print ", "
    li a7, 4
    la a0, space
    ecall

    # Decrease countdown
    addi t1, t1, -1
    j loop

liftoff_label:
       # Print ", "
    li a7, 4
    la a0, space
    ecall
    
    # Print "Liftoff!"
    li a7, 4
    la a0, liftoff
    ecall
    
    # Exit program
    li a7, 10
    ecall
