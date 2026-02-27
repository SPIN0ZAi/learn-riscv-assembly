.data
txt: .string "The maximum number is : "

vector: .byte 2,33,4,0,63,127,8,9,5,19
size: .word 10


.text

  la t2,vector
  lw t1,size
  lb s0,0(t2)
  
loop:
    lb t0,0(t2)
    
    ble t0,s0,not_bigger
    
    #replace
    
    mv s0,t0
  
not_bigger:
    
    addi t2,t2,1
    addi t1,t1,-1
    bgtz t1,loop
        #print the text
    la a0,txt
    li a7,4
    ecall
    
    
    
    #print the biggest number
    mv a0,s0
    li a7,1
    ecall
    
    
#EXITE
li a7 ,10
ecall
    
  