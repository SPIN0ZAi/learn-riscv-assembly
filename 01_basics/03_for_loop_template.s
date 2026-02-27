.text


for:
    #for(i=0;;)
    li s0,0   # i = 0
    
for_iteration:
    #for(; i < j)
    
    blt s0,s1,end_for
    
    #for loop
    
    slli t0,s0,2
    add t0,s3,t0
    sw s2,0(t0)
    
    #for(;;i++)
    
    addi s0,s0,1
    
    #}
    j for_iteration
    
end_for:
    

    
    li a7,10
    ecall