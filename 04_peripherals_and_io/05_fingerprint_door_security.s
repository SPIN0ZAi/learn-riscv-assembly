############################  Definitions
.equ OSExit 10
.equ FingerPrint  0xf000500
.equ DoorLock     0xf000200
.data
Fingerprints: .zero 1014


.text ########################  code



la s0 Fingerprints  # this to save the fingerprints

loop:
    
    
    la t0 FingerPrint
    lw t1 0(t0)
    
    
    li t2 0b000000000000000000000100000000   # Isolating the 9th bit
    
    or t1 t1 t2
    
    beqz t1 loop # stay lopping until the 9th is not 0 ( like 1 )
    
    
    #Reset the bit
    call Reset
    
    #Reads the fingerprint
    
    la t0 FingerPrint
    lw a0 4(t0) # instead of t1 we are using a0 since it the input argument in the subroutine
    
    
    # Validate the fingerprint.

    call Validatethefingerprint
    
    #if the fingerprint is not authorized, repeat 
       
    
    beqz a0 loop
    
    # the fingerprint is authorized 
    
    call OpenDoor
    
    # Store the finger print in memory in the reserved area 
    
    la t0 FingerPrint # we need to have the fingerprint again
    lw t1 4(t0) # that why we load it again
    sw t1 0(s0)
    
    addi s0 s0 4 # increment the pointer to the next position
    
    #here
    
    
    
    
    j loop



end:  
    
    li a7 OSExit
    ecall
    
    
    
    
####################################################################4
Reset:
    
    # no arguments
    
    la t0 FingerPrint
    
    lw t1 0(t0)  
    
    
    li t2 0b111111111111111111111011111111   # changing the 9th bit to 0 while keeping others
    
    or t1 t1 t2
    
    
    sw t1 0(t0)
    
      
    ret
    
    
####################################################################4
OpenDoor:
    
    # no arguments
    
    la t0 DoorLock
    
    lw t1 0(t0)  
    
    
    li t2 0b000000000010000000000000000000  # changing the 20th bit to 1 and keeping others
    
    or t1 t1 t2
    
    
    sw t1 0(t0)
    
      
    ret
####################################################################
Validatethefingerprint:
    # INPUT arguments:
        #a0L fingerprint
        
    #OUTPUT arguments
    #a0: (1) validated (0) not validated
    #...
    ret