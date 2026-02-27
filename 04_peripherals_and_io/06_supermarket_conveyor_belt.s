############################  Definitions
.equ OSExit 10
.equ IOBelt  0xffff6000



.text ########################  code

   la t0 IOBelt

   #BELT   VV-vv-MM-LLLL--O

   li t1 0b1001100000110000
   
   sw t1 0(t0)  # initial configuration


loop:
    #read the sensor
    lw t1 0(t0)
    
    andi t1 t1 1  #isloate 0 field
    
    
    bnez t1 detected
    
    # object is not detected
        
        
      #BELT   VV-vv-MM-LLLL--O ,,,, this to put a one in that place

      li t1 0b0000000100000000
      
      or t1 t1 t2
      
      #BELT   VV-vv-MM-LLLL--O,,, put a zero since we need to have 01 

      li t1 0b1111110111111111  
      
      and t1 t1 t2
      
   
      j next
    
    
    
    #move
    
detected:
    
    #object is detected
    
    #stop
      
      #BELT   VV-vv-MM-LLLL--O 

      li t2 0b1111100111111111  
      
      and t1 t1 t2
      
    
next:
    
    sw t1 0(t0)
    
    j loop
    
    
end:  
    
    li a7 OSExit
    ecall
    