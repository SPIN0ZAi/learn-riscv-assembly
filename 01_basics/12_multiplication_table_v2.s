.data
text_add: .string " x "
text_eq: .string " = "
text_newline: .string "\n"



.text

li t1,11

li s0,23

li t0,0

loop:
    beq t1,t0,end_loop 
   mul t2,s0,t0  # Multiply result by s0

#printing value of 23
mv a0,s0
li a7,1
ecall

#printing the plus sign
la a0,text_add
li a7,4
ecall

#printing the value of iterationn
mv a0,t0
li a7,1
ecall
#printing the equal sign
la a0,text_eq
li a7,4
ecall


#printing the value of iterationn
mv a0,t2
li a7,1
ecall

#printing the new line
la a0,text_newline
li a7,4
ecall


addi t0, t0, +1         # Increment s0

j loop

end_loop:
#EXIT to  OS
li a7,10
ecall