.text # start of the program

  bne s3,s4,if_F
  
if_TRUE:
    
    add ,s0,s1,s2
    
    j  EXITCONDITION
  
  
  
if_F:
    
   sub s0,s1,s2
    
    

EXITCONDITION:
    nop
    
    
addi , s7,zero ,10 # EXIT
ecall