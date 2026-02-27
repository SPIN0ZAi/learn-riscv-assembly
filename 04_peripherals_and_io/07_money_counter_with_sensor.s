.equ OSExit 10
.equ SENSORS 0xf0000400
.equ OSscanBill 201


.text

 li s0 0 # amount of bills
 li s1 0 # amount of money

loop:
    
 lw t0 SENSORS

 andi t0 t0 0b1 # isolate S bit

 beqz t0 noBills


  li a7 OSscanBill
  ecall # scanBill : calling the function that gives us the value of the bill in a0
  
  
  addi s0 s0 1 # counting a bill +1
  
  add s1 s1 a0 # adding the value of the bill | money += bill
  

noBills:
    
      sw s0 4(t0) # updating left screen/display
      sw s1 8(t0) # updating right screen/display
  
  
    
  andi t1 t0 0b10 # isolate B bit
  beqz t1 loop 
  
  # reset B bit
  
  li  t1 0xffffd   # mask
  
  and t0 t0 t1
  
  sw t0 SENSORS t1
  
  # reset displays
  
  li s0 0
  
  li s1 0

    
    j loop

li a7 OSExit
ecall
nop