.data
starting: .string "Starting the proccess..."
new_line: .string "\n"
space: .string ", "
end_proccess: .string "proccess done"
new_values: .string "The values in V2 now is :"
V1: .byte 2,5,3,5,2,4,8,0,1
size: .word 10
V2: .zero 10

.text
li s6,10
la t0,V1
la t1,V2
lw t2,size
  addi t2, t2, -9 

    # Print "string "
    li a7, 4
    la a0, starting
    ecall 
    
    # Print "string "
    li a7, 4
    la a0, new_line
    ecall 
    
        # Print "string "
    li a7, 4
    la a0, end_proccess
    ecall
        
    # Print "string "
    li a7, 4
    la a0, new_line
    ecall 
    
        # Print "string "
    li a7, 4
    la a0, new_values
    ecall
            

      


loop:
    
   beq t2,s6,start_printing
   
   lb s0,0(t0)
   
   add s1,zero,s0
   
   sb s0,0(t1)
   
   addi,t0,t0,1
   
   addi,t1,t1,1
   
   addi t2,t2,+1
   
   j loop
    
    
    
start_printing:
        lw s3,size
        
        
loop_print:
    beqz s3,end
    
    lb s4,0(s3)
    
    # Print biggest
    mv a0, s4
    li a7, 1
    ecall
    
            # Print "string "
    li a7, 4
    la a0, space
    ecall
    
    
  addi s3,s3,-1
    j loop_print
           
    
 
    
    end:
    
#exit

li a7,10
ecall