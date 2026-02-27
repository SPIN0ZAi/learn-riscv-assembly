.data
space: .string "  "
com: .string ", "
Tminus: .string "T-minus"
liftoff: .string "liftoff!"

.text
li t1,10
li s0,0

      
     la a0, Tminus
     li a7, 4
      ecall
      
               # Print "  "
     la a0, space
     li a7, 4
      ecall
   

# Compute factorial
loop:
    beq t1,s0,end_loop
        
         #print value of t1
     mv a0, t1
     li a7, 1
     ecall
     
         # Print "  "
     la a0, com
     li a7, 4
      ecall
   

    

      
      addi t1, t1, -1         # Increment s0
      j loop                  # Repeat

end_loop:
    
      la a0, liftoff
     li a7, 4
      ecall


    # Exit program
    li a7, 10
    ecall
