.equ OSExit  10
.equ OSPrintINterg  1


.data
waypoints: 
.word 0x3708034E  #waypoint 0
.word 0x04281557
.word 7000
.word 240

.word 0x3703194E  #waypoint 1
.word 0x04562357
.word 5000
.word 160



.word 0x3648504E  #waypoint 2
.word 0x04413957
.word 32000
.word 140



.word 0x3640004E  #waypoint 3
.word 0x04292057
.word 52
.word 0


#######################################################################
 .text


 li a0 1 # current WP

 call dis2dest
 
 
 #a0 = distance / we dont need to do mv a0 a0 
 li a7 OSPrintINterg
 ecall

 


 li a7 OSExit
 ecall


#######################################################################

dis2dest:
    #INPUT
    # a0: current WP
    #OUTPUT
    #a0: total distance
    
    li    t0 16  # size of each WP
    mul   s0 t0 a0
    # another option  slli s0 a0 4 for the two lines above li + mul
    la    t0 waypoints
    add   s0 s0 t0    # pointer to the current way point
    
    li    s1 0  # total distance so far
    
    call GPS               # a0 / a1 = lat / lon

loop:
    
    #a2 / a3 = lat_i / lon_i
    
    lw    a2 0(s0)
    
    lw    a3 4(s0)
    
    call dis2pt   # a0 = distance/ d_i
    
    add   s1 s1 a0  # d = d + d_i  / adding to total distance
    
    
    mv    a0 a2  # lat = lat_i
    
    mv    a1 a3  # lon = lon_i
    
    
    lw    t0 12(s0)  # getting vel_i
    
    addi  s0 s0 16   # next WP
    
    bgtz  t0 loop  # branch if t0=vel_i is greater than 0
    
    mv a0 s1
    
  
  ret
  
  
  GPS:
      #INPUT
      #nothing
      
      #Output
      #a0: latitude
      #a1: longitude
      
      # here is the code 
  ret
  
  dis2pt:
     #INPUT  this values are not modified
      #a0: latitude  1
      #a1: longitude 1
      #a2: latitude  2
      #a3: longitude 2
      
      #Output
      #a0: distance berween points
   
      
      # here is the code
  ret