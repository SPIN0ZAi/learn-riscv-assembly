############################  Definitions
.equ OSExit 10



.text ########################  code





end:
    
    
    li a7 OSExit
    ecall
    
    
    
    
####################################################################4
Reset:
    
    # no arguments
    
    la t0 0xf0005000
    
    lw t1 0(t0)  
    
    
    li t2 0b111111111111111111111011111111   # changing the 9th bit to 0 and keeping others
    
    or t1 t1 t2
    
    
    sw t1 0(t0)
    
      
    ret
    
    
####################################################################4
OpenDoor:
    
    # no arguments
    
    la t0 0xf0002000
    
    lw t1 0(t0)  
    
    
    li t2 0b000000000010000000000000000000  # changing the 20th bit to 1 and keeping others
    
    or t1 t1 t2
    
    
    sw t1 0(t0)
    
      
    ret