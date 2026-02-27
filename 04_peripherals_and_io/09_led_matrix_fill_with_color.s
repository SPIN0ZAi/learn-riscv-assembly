.data




.text

loop:
    
 li s0,12288
 beq t1,s0,end
    
li t0,0x000000FF
la t1,LED_MATRIX_0_BASE
sw t0,0(t1)

addi t1,t1,4

j loop

end:
li a7,10
ecall