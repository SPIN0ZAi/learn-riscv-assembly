####### Definitions ######
.data
.equ COLOR_BLACK 0xff000000
.equ COLOR_RED 0xffff0000
.equ COLOR_GREEN 0xff00ff00
.equ COLOR_YELLOW 0xffffff00
.equ COLOR_BLUE 0xff0000ff
.equ COLOR_MAGENTA 0xffff00ff
.equ COLOR_CYAN 0xff00ffff
.equ COLOR_WHITE 0xffffffff

.equ OSExit 10

.text # Code
    # LEFT EYE (green)
    li a0, 10   # X position
    li a1, 6   # Y position
    li a2, 1   # Width
    li a3, 6   # Height
    li a4, COLOR_GREEN
    call PlotTriangle
    
    # RIGHT EYE (green)
    li a0, 27  # X position
    li a1, 6   # Y position
    li a2, 1   # Width
    li a3, 6   # Height
    li a4, COLOR_GREEN
    call PlotTriangle
    
    # MOUTH (red)
    li a0, 10  # X position
    li a1, 20  # Y position
    li a2, 18  # Width
    li a3, 4   # Height
    li a4, COLOR_WHITE
    call PlotBox
    
    # NOSE (magenta)
    li a0, 18  # X position
    li a1, 14  # Y position
    li a2, 2   # Width
    li a3, 3   # Height
    li a4, COLOR_RED
    call PlotBox


# prepare the input 
#li a2 COLOR_WHITE
#li a0, 29   # X position
#li a1, 20   # Y position

#call the function
#call PlotPixel

 li a7, OSExit
 ecall
 
 
 
 
#######################################################################
PlotTriangle:
    #Input:
        # X position
        # Y position
        # X size/Width = always start at 1 value  
        # Y size/hieght
        
        
     addi sp sp -28
     
     sw ra 0(sp)
     
     sw s0 4(sp)
     
     sw s1 8(sp)
     
     sw s2 12(sp)
     
     sw s3 16(sp)
     
     sw s4 20(sp)
     
     sw s5 24(sp)
     
      mv s0 a0
      mv s1 a1
      mv s2 a2
      mv s3 a3
      mv s4 a4
      
      
LoopColumn_T:
    
    mv s5 s2
    
    
    LoopROW_T:
        
       mv a0 s0  # moving the value of x position
    
       mv a1 s1  # moving the value of y position
    
       mv a2 s4  # moving the value of color
       
       call PlotPixel
       
      addi s0 s0 1 # x position ++
      
      addi s5 s5 -1 # x size --
      
      bgtz s5 LoopROW_T
      
      sub s0 s0 s2 # reset 
      
      addi s0 s0 -1 # negative 1 position
      
      addi s2 s2 2
      
      addi s1 s1 1  # Y++
      
      addi s3 s3 -1 # y size --
      
      bgtz s3 LoopColumn_T
      
      
     lw ra 0(sp)
     
     lw s0 4(sp)
     
     lw s1 8(sp)
     
     lw s2 12(sp)
     
     lw s3 16(sp)
     
     lw s4 20(sp)
     
     lw s5 24(sp)
     
     
 
     addi sp sp 28
        
    ret

#######################################################################
PlotBox:
    #input:
        # a0: x position
        # a1: y position
        # a2: Width
        # a3: height
        # a4: color
        

     addi sp sp -28
     
     sw ra 0(sp)
     
     sw s0 4(sp)
     
     sw s1 8(sp)
     
     sw s2 12(sp)
     
     sw s3 16(sp)
     
     sw s4 20(sp)
     
     sw s5 24(sp)
     
      mv s0 a0
      mv s1 a1
      mv s2 a2
      mv s3 a3
      mv s4 a4
      
      
      
      
      

LoopColumn:
    
   mv s5 s2 # saving the original value
    
  LoopROW:
      
      
       mv a0 s0  # moving the value of x position
    
       mv a1 s1  # moving the value of y position
    
       mv a2 s4  # moving the value of color
      
      call PlotPixel
      
      addi s0 s0 1 # x position ++
      
      addi s5 s5 -1 # x size --
      
      bgtz s5 LoopROW
        
      sub s0 s0 s2 # X = X - Xs
      
      addi s1 s1 1  # Y++
      
      addi s3 s3 -1 # y size --
      
      bgtz s3 LoopColumn
      
      
  
     lw ra 0(sp)
     
     lw s0 4(sp)
     
     lw s1 8(sp)
     
     lw s2 12(sp)
     
     lw s3 16(sp)
     
     lw s4 20(sp)
     
     lw s5 24(sp)
     
     
     
     addi sp sp 28
     
     

    ret

#######################################################################
PlotPixel:
 # assign this before calling the function
     # a0: x position
     # a1: y position
     # a4: color
    
    
     la t0 LED_MATRIX_0_BASE
    
     li t1 LED_MATRIX_0_WIDTH
     
     li t2 LED_MATRIX_0_HEIGHT
     
     
     bltz a0 EndPP
     bgt a0 t1 EndPP
     
     bltz a1 EndPP
     bgt a1 t2 EndPP
     
     # Calculate address : pixel_offset = (y * WIDTH + x) * 4
     
     mul t3 a1 t1
     
     add t3 t3 a0
     
     li t4 4
     
     mul t3 t3 t4 # slli t3 t3 2
     
     add t3 t0 t3
     
     sw a2 0(t3)
    
  EndPP: 
    ret
       

#######################################################################
FillScreen:
    la t0 LED_MATRIX_0_BASE # where is the screen in memory
    li t2 LED_MATRIX_0_SIZE # size ( as a number ) of the screen
    
LoopFS:
    
    sw a0 0(t0)   #store the color
    
    addi t0 t0 4  # increment by 4 to go to next pixel
    addi t2 t2 -1 # size - 1 
    
    bgtz t2 LoopFS # if the size is 0 stop
    
    ret



