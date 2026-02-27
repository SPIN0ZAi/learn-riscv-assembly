.data 
data1: .word 0xDEADBEEF
data2: .word 5
result: .word 0

.text
main:
    
    la t0,data1  # Pointer to memory of data1
    lw t1,0(t0)  # Load data1
    lw t2,4(t0)  # Load data2
    add s0,t1,t2 # the sum of data1 and data2 
    la t0,result # Pointer to memory 
    sw s0,0(t0)  # Store result in memory

    
exit:
    addi a7,zero,10
    ecall