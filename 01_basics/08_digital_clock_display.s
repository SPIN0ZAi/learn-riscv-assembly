.data
txt: .string ":"
txt1: .string "  "
zero: .string "0"


.text

li t0,0
li t1,00
li t3,60
li s0,10


startloop:  
  addi t1,t1,1
    beq t1,t3,reset
    
     blt t0,s0,print_leading_zero_hour
     
 return1:
     
    
          #print value of hours
     mv a0, t0
     li a7, 1
     ecall
     
     
    
    
               # Print ":"
     la a0, txt
     li a7, 4
      ecall
      
      blt t1,s0,print_leading_zero_minute
      
  return2:
                #print value of minute
     mv a0, t1
     li a7, 1
     ecall
     
                    # Print " "
     la a0, txt1
     li a7, 4
      ecall

     j startloop
     
print_leading_zero_hour:
       
                    # Print "0"
     la a0, zero
     li a7, 4
      ecall
  j return1
      
      
print_leading_zero_minute:
    
      la a0, zero
     li a7, 4
      ecall
  j return2

reset:
    li t1,0
    # increment
      addi t0,t0,1
    j startloop
    


    # Exit program
    li a7, 10
    ecall
    
    