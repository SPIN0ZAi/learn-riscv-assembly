.data

num1: .word 0x00005555
num2: .word 0x000015B3
num3: .word 0x0



.text

  la t0 num1
  la t1 num2
  la t2 num3
  
  lw t5 0(t2)
  
  li t6 32
  
  
loop:
    
  lb t3 0(t0)
  lb t4 0(t1)

  bne t3 t4 notequal
     
   addi t6 t6 -1
   bnez t6 loop
   
   li t5 5
   sw t5 0(t2)
   
   j end

notequal:
    
    li t5 1
    sw t5 0(t2)
    
end:
    
   li a7 10
   ecall
 