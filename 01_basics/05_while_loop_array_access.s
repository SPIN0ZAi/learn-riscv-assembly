.text

while:
    
    
    #check
    slli t0,s0,2  #translate index to bytes
    add t0,s3,t0  #pointer to the i-element
    
    lw t0,0(t0)   #loading the element
    
    bne t0,s2,end_while   #finish if condition is false
    
    
    #loop body
    
    add s0,s0,s1
    
    #iterate
    
    
    addi t0,t0,-1
    
    end_while:
        
    nop
    
