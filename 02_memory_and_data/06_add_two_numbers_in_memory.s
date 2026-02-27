.data 

num1: .word 0x200
num2: .word 0x300
result: .word 0

.text

 lw t0 num1
 lw t1 num2
 add t2 t0 t1

option1:
  
  la t3 result
  
  sw t2 0(t3)

exit:
    li a7 10
    ecall