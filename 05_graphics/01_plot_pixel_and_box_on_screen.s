####### Definitions #######
.equ COLOR_BLACK 0xff000000
.equ COLOR_RED 0xffff0000
.equ COLOR_GREEN 0xff00ff00
.equ COLOR_YELLOW 0xffffff00
.equ COLOR_BLUE 0xff0000ff
.equ COLOR_MAGENTA 0xffff00ff
.equ COLOR_CYAN 0xff00ffff
.equ COLOR_WHITE 0xffffffff

.equ OSExit 10

.text
main:
    li a0,COLOR_BLUE
    call FillScreen
    

    
    # LEFT EYE (green)
    li a0, 8   # X position
    li a1, 6   # Y position
    li a2, 6   # Width
    li a3, 6   # Height
    li a4, COLOR_GREEN
    call PlotBox
    
    # RIGHT EYE (green)
    li a0, 18  # X position
    li a1, 6   # Y position
    li a2, 6   # Width
    li a3, 6   # Height
    li a4, COLOR_GREEN
    call PlotBox
    
    # MOUTH (red)
    li a0, 10  # X position
    li a1, 20  # Y position
    li a2, 12  # Width
    li a3, 4   # Height
    li a4, COLOR_WHITE
    call PlotBox
    
    # NOSE (magenta)
    li a0, 15  # X position
    li a1, 14  # Y position
    li a2, 2   # Width
    li a3, 3   # Height
    li a4, COLOR_MAGENTA
    call PlotBox
    
    li a7, OSExit
    ecall

# [Rest of your existing functions: PlotBox, PlotPixel, FillScreen]
    
    
loop_plotting:
    
  #  sw t2 0(t1)
    
  #  addi t1,t1,4 # because each pixel is 4 byte
    
   # addi t0,t0,-1
    
  #  bgtz t0,loop_plotting
    
    
   # li a7  OSExit
    
    
    
#############################################################
PlotBox:
    # a0: x position
    # a1: y position
    # a2: x size or width of the box
    # a3: y size
    # a4: color
    
    addi sp sp -28
    
    sw ra 0(sp) # save/store return address

    sw s0 4(sp)
    
    sw s1 8(sp)
    
    sw s2 12(sp)
    
    sw s3 16(sp) 
    
    sw s4 20(sp)  
    
    sw s5 24(sp) 
    
    mv s0 a0  # X pos
    mv s1 a1  # Y pos
    mv s2 a2  # X size
    mv s3 a3  # Y size
    mv s4 a4  # color
    
    
    
    
    
rowPB:
    
    mv s5 s2  # temperale X size to count where we are horizontally
    
columnPB:
    
    mv a0 s0 # coordinate X poistion
    
    mv a1 s1 # coordinate Y poistion
    
    mv a2 s4 # color
    # a0 x
    # a1 y
    # a2 color
    
   call PlotPixel
   
   addi s0 s0  1  # X++
    
   addi s5 s5 -1
   
   bgtz s5 columnPB
   
   sub s0 s0 s2 # X = X - Xs
   
   addi s1 s1 1 # Y++
  
   addi s3 s3 -1
   
   bgtz s3 rowPB
   
   
   
   
   
    
    lw ra 0(sp) # laod return address

    lw s0 4(sp)
    
    lw s1 8(sp)
    
    lw s2 12(sp)
    
    lw s3 16(sp) 
    
    lw s4 20(sp) 
    
    lw s5 24(sp)

    addi sp sp 28
    
    
   ret
    
    
    
#############################################################
PlotPixel:
    # a0: x position
    # a1: y position
    # a2: color

    la t0 LED_MATRIX_0_BASE
    li t1 LED_MATRIX_0_WIDTH   # WIDTH = 64
    li t2 LED_MATRIX_0_HEIGHT  # HEIGHT = 48

    bltz a0 EndPP
    bgt a0 t1 EndPP

    bltz a1 EndPP
    bgt a1 t2 EndPP

    # Calculate address: pixel_offset = (y * WIDTH + x) * 4
    mul t3 a1 t1      # t3 = y * WIDTH
    add t3 t3 a0      # t3 = y * WIDTH + x
    slli t3 t3 2      # t3 = (y * WIDTH + x) * 4
    add t3 t0 t3      # t3 = base address + offset

    sw a2 0(t3)

EndPP: 
    ret

  
  
  
#############################################################
FillScreen:
    # a0: contain the color
    
        la t0 LED_MATRIX_0_BASE
        
    
        li t1,LED_MATRIX_0_SIZE #define LED_MATRIX_0_SIZE (0x3000)
loopFS:   
        sw a0 0(t0)
        addi t0 t0 4
        addi t1,t1,-1
        bgtz t1 loopFS

    
    ret