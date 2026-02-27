.data

var1: .word 5555

var2: .word 0x15B3

Var3: .word 0

.text

la t0,var1  # loading the address memory of var1 in t0

lw t1,0(t0)

lw t2,4(t0)


bne t1,t2,not_eq

#they are equal

li t3,5 # case of Var1 = Var2

j  store # skip not equal and go directly to store

not_eq:  
li t3,1 # case of Var1 != Var2

store:
    
sw t3,8(t0)


addi a7,zero,10   # EXIT
ecall