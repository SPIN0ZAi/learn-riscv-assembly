.data

result: .zero 4

.text

 li t1 0x1024
 li t2 0x30000
 add t4 t1 t2
 la t3 result
 sw t3 0(t4)
 
 
li a7 10
ecall