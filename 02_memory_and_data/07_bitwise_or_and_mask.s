.data
num1: .word 0xF2345670
num2: .word 0x0


.data

 la t0 num1
 la t1 num2
 
 lw t2 0(t0)
 
 li t4 0x3cFFFFFF # for and
 li t5 0x00000003
 
 or t2 t2 t5
 
 and t2 t2 t4 
 
 
 sw t2 0(t1)


  
  
  

