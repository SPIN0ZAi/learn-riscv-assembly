#############################
.equ OSExit      10
.equ OSTime      30
.equ OSPrintInt  1
.equ OSPrintChar 11
.equ IOReader 0xffff504
.equ IOLock   0xffff504
.equ IOClock  0xffff504

.text

loop: # constantly check the status bit

  lw t0 IOReader # We et the the port value
  
  li t1 0b000000000000000000000000100000 # we use this mask to isolate the bit where the detecter 
  
  and t0 t0 t1 # we mask and get only the bit we need
  
  beqz t0 loop # if the value in t0 is 0 then we repeat
  
  #In this part we did detect a car ( car is present )
  
  call ReadTime
  
  #output from ReadTime a0: time
  
  call ValidateTime
  
  beqz a0 loop  #time was not validated, then we jump to the beginning
  
  # The time was validated
  
  call OpenDoor
  
  li a0 3  # amount of seconds we want to delay to pass to delay function
  
  call Delay
  
  call CloseDoor
  
  
  
  
  j loop

 

end:
    li a7, OSExit
    ecall
    
###############################################################
OpenDoor:
     la t0 IOLock
     lw t1 0(t0)
     li t2 0b001000000000000000000000000000
     or t1 t1 t2
     sw t1 0(t0)
     ret
     
CloseDoor:
     la t0 IOLock
     lw t1 0(t0)
     li t2 0b110111111111111111111111111111
     and t1 t1 t2
     sw t1 0(t0)
     ret
     
     

ReadTime:
    #OUTPUT
    #a0: time
    # TIME -----------------HHHHHMMMMMSSSSS
    lw t0 IOLock
    li t2 0b000000000000000111111111111111
    and t1 t1 t2
    ret


ValidateTime:
    #Input a0: time
    #OUTPUT a0: (1) validated (0) not validated
    
    #The code is here
    
    ret
    
Delay:
    #Input a0: amount of seconds to delay
    
    #The code is here
    
    ret