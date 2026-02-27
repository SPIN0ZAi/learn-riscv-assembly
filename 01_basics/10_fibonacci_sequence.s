.data
txt: .string " 9 first Fibonacci numbers: "
txt1: .string "  "
newline: .string "\n"  # Define a newline character

.text
li t1,0      # first
li t2,1      # second
li t3,0      # third number
li s0,7      # max iterations

     # Print "9 first Fibonacci numbers:"
     la a0, txt
     li a7, 4
      ecall
   # Print "newline"
     la a0, newline
     li a7, 4
      ecall

 #print value of t1 in first
     mv a0, t1
     li a7, 1
     ecall
     
           # Print "space"
     la a0, txt1
     li a7, 4
      ecall
     
      #print value of t2
     mv a0, t2
     li a7, 1
     ecall
     
           # Print "space"
     la a0, txt1
     li a7, 4
      ecall

# Fibonacci
loop:
    beq s0, zero, end_loop  # Stop when when s0 reach 9
    add t3, t2, t1          # Multiply result by s0
    


      #print value of input
      mv a0, t3
      li a7, 1
      ecall
      # Print "space"
     la a0, txt1
     li a7, 4
      ecall
      
      addi t1,t2,0
      addi t2,t3,0


      addi s0, s0, -1         # Increment s0
      j loop                  # Repeat

end_loop:


    # Exit program
    li a7, 10
    ecall
