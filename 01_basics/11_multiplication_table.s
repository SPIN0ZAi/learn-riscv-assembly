.data
txt: .string " x "
txt1: .string " = "
newline: .string "\n"  # Define a newline character

.text
li s0, 5      # Number 
li t0, 5      # multiplication result initialized to 1
li t1,1      # current iteration
li t2,11      # current iteration


# Compute factorial
loop:
    beq t1, t2, end_loop  # Stop when t1 reaches t2=11
    mul t0, s0, t1          # Multiply result by s0
    #print value of input
     mv a0, s0
     li a7, 1
     ecall
     
     # Print "x"
     la a0, txt
     li a7, 4
      ecall
      #print value of input
      mv a0, t1
      li a7, 1
      ecall
      # Print "="
     la a0, txt1
     li a7, 4
      ecall
      #print value of result
      mv a0, t0
      li a7, 1
      ecall
     # Print "newline"
     la a0, newline
     li a7, 4
      ecall
      
      addi t1, t1, +1         # Increment s0
      j loop                  # Repeat

end_loop:


    # Exit program
    li a7, 10
    ecall
