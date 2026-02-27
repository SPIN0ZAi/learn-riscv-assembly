# TOPIC 02 /  1

.data
RESULT: .word 0x0,0x0

.text
  li t0,0x200
  
  li t1,0x300
  
  add t2,t0,t1
  
  la t3,RESULT
  
  sw t2,0(t3)
  
  exit:
      li a7,10
      ecall
      
      
# TOPIC 02 /  2

.data
RESULT2: .word 0x0,0x0

.text
  addi t0,zero,1024
  
 # addi t1,zero,0x30000  we cant do this
 
 li t1,0x30000
 
 add t2,t0,t1
  
  
  la t3,RESULT
  
  sw t2,0(t3)
  
  exit2:
      li a7,10
      ecall
      
# TOPIC 02 /  3

.data
RESULT3: .word 0x0,0x0
NUM1: .word 0x0
NUM2: .word 0x0

.text

  lw t0,NUM1 
  
  lw t1,NUM2
  

  add t5,t0,t1
  
  la t2,RESULT
 
  sw t5,0(t2)   # also correct sw t5,RESULT,t2
 
  
  exit3:
      li a7,10
      ecall
      
      
      
      
      
  # TOPIC 02 /  4
  
  START4:
      
  .text
  
  li s0 0x001ff0f
  li s1 0x00f0020
  li s2 0x20
  
  and t0,s0,s1
  or t1,s0,s1
  ori t2,s0,0x750
  slli t3,s2,2
  srai t4,s2,3
  
    exit4:
      li a7,10
      ecall
      
  
  
    # TOPIC 02 /  4
  
  START5:
  num1: .word 0x1234567F
  num2: .word 0xFFFFFFFF
  
  .text
  li t0, 0xFFFFFFF3
  neg t0 t0
  lw t1 num1
  lw t2 num2
  
  andi t1, t1, 0xFF3
  
  or t1, t1, t0

    exit5:
      li a7,10
      ecall
      
      
      

      
      