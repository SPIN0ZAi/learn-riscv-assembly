li t0,0


repeat:
    nop
    nop 
    # loop condition
    addi t0,t0,-1
    bnez t0,repeat
    
    end_loop:
        li a7,10
        ecall
    