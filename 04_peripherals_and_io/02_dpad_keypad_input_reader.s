.data  ####################################

txtUP:    .string "UP\n"
txtDOWN:  .string "DOWN\n"
txtLEFT:  .string "LEFT\n"
txtRIGHT: .string "RIGHT\n"

.text  ####################################
loop:
    


    # Check UP key
    lw t0, D_PAD_0_UP
    beqz t0, skipUP
    la a0, txtUP
    li a7, OSPrintString
    ecall
skipUP:

    # Check DOWN key
    lw t0, D_PAD_0_DOWN
    beqz t0, skipDOWN
    la a0, txtDOWN
    li a7, OSPrintString
    ecall
skipDOWN:

    # Check LEFT key
    lw t0, D_PAD_0_LEFT
    beqz t0, skipLEFT
    la a0, txtLEFT
    li a7, OSPrintString
    ecall
skipLEFT:

    # Check RIGHT key
    lw t0, D_PAD_0_RIGHT
    beqz t0, skipRIGHT
    la a0, txtRIGHT
    li a7, OSPrintString
    ecall
skipRIGHT:
    
    lw t0,SWITCHES_0_BASE
    
    andi t0,t0,1
    
    beqz t0,loop # Continue looping
    

   
    
end:

li a7, OSexit
ecall

############################################
.equ OSexit         10
.equ OSPrintString   4
