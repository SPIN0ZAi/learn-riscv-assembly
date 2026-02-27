####### Definitions ######
.data
.equ COLOR_BLACK, 0xff000000
.equ COLOR_RED, 0xffff0000
.equ COLOR_GREEN, 0xff00ff00
.equ COLOR_YELLOW, 0xffffff00
.equ COLOR_BLUE, 0xff0000ff
.equ COLOR_MAGENTA, 0xffff00ff
.equ COLOR_CYAN, 0xff00ffff
.equ COLOR_WHITE, 0xffffffff

.equ OSExit, 10

.text # Code

    # Clear the screen with black
    li a0, COLOR_BLUE
    call FillScreen
    
    li a0, 20      
    li a1, 12       
    li a2, 3        
    li a3, COLOR_WHITE 
    call Plot_a_cross
    
    
    li a0, 45      
    li a1, 2       
    li a2, 7        
    li a3, COLOR_RED 
    call Plot_a_cross
    
    li a0, 50      
    li a1, 40       
    li a2, 3        
    li a3, COLOR_YELLOW 
    call Plot_a_cross
    
    
    li a0, 15      
    li a1, 35       
    li a2, 9        
    li a3, COLOR_YELLOW 
    call Plot_a_cross
    
    li a0, 15      
    li a1, 35       
    li a2, 3        
    li a3, COLOR_GREEN 
    call Plot_a_cross
   
   
    
   
   
    li a7, OSExit
    ecall

#######################################################################
PlotTriangle:
    # Input:
    # a0: x position (center of apex)
    # a1: y position (top of triangle)
    # a2: width (not used as width; assume apex starts with 1 pixel)
    # a3: height (number of rows)
    # a4: color

    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)

    mv s0, a0  # x position (center)
    mv s1, a1  # y position
    mv s2, a2  # width (not used directly)
    mv s3, a3  # height
    mv s4, a4  # color

    li s5, 0   # Current row number (0 to height-1)
    li s6, 0   # Current offset (pixels to left/right of center)

LoopRow_T:
    # Calculate starting x position for this row: x - offset
    sub t0, s0, s6  # t0 = x - offset
    mv t1, s6       # t1 = offset (for loop counter)
    add t2, s6, s6  # t2 = 2 * offset
    addi t2, t2, 1  # t2 = 2 * offset + 1 (total pixels in row)

LoopPixel_T:
    mv a0, t0       # x position
    mv a1, s1       # y position
    mv a2, s4       # color
    call PlotPixel

    addi t0, t0, 1  # Move to next x position
    addi t1, t1, -1 # Decrement pixel counter
    bgez t1, LoopPixel_T  # Continue until all pixels in row are drawn

    # Move to next row
    addi s1, s1, 1  # y++
    addi s5, s5, 1  # row++
    addi s6, s6, 1  # offset++ (widen triangle)
    blt s5, s3, LoopRow_T  # Continue until height is reached

    # Restore registers
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28

    ret

#######################################################################
PlotBox:
    # Input:
    # a0: x position
    # a1: y position
    # a2: width
    # a3: height
    # a4: color

    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)

    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4

LoopColumn:
    mv s5, s2 # saving the original width value

LoopRow:
    mv a0, s0  # x position
    mv a1, s1  # y position
    mv a2, s4  # color
    call PlotPixel

    addi s0, s0, 1  # x position ++
    addi s5, s5, -1 # width --
    bgtz s5, LoopRow

    sub s0, s0, s2  # Reset x position
    addi s1, s1, 1   # y position ++
    addi s3, s3, -1  # height --
    bgtz s3, LoopColumn

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28

    ret

#######################################################################
PlotPixel:
    # Input:
    # a0: x position
    # a1: y position
    # a2: color

    la t0, LED_MATRIX_0_BASE
    li t1, LED_MATRIX_0_WIDTH
    li t2, LED_MATRIX_0_HEIGHT

    bltz a0, EndPP
    bge a0, t1, EndPP
    bltz a1, EndPP
    bge a1, t2, EndPP

    # Calculate address: pixel_offset = (y * WIDTH + x) * 4
    mul t3, a1, t1
    add t3, t3, a0
    li t4, 4
    mul t3, t3, t4
    add t3, t0, t3
    sw a2, 0(t3)

EndPP:
    ret

#######################################################################
FillScreen:
    # Input:
    # a0: color

    la t0, LED_MATRIX_0_BASE
    li t2, LED_MATRIX_0_SIZE

LoopFS:
    sw a0, 0(t0)    # Store color
    addi t0, t0, 4  # Next pixel
    addi t2, t2, -1 # Size --
    bgtz t2, LoopFS

    ret

#######################################################################

Plot_a_cross:
    # Input:
    # a0: center x position
    # a1: center y position
    # a2: size (length of each arm; total width/height = size * 2 + 1)
    # a3: color


#Saving registers because we are calling plotbox
   addi sp, sp, -20
   sw ra, 0(sp)
   sw s0, 4(sp)
   sw s1, 8(sp)
   sw s2, 12(sp)
   sw s3, 16(sp)
#moving values to save registers for more safer code
   mv s0, a0  
   mv s1, a1  
   mv s2, a2  
   mv s3, a3  
   
   #check if the value is size is odd 
   
   # andi s2 s2 1 I have commented this since Im not sure it works like this
   
   # beqz s2 end 

  # horizontal arm: box at (x - size, y - thickness/2) with width = 2 * size + 1, height = thickness
  # in this case i need to pass arguments to plotbox
  # in a paper I got that to make it possible i need to plot the boxes as follow 
  # box 1 at (x,y) and box 1 at (y,x) to get the effect of cross
  
  sub a0, s0, s2      # x - size
  mv t0, s2            # thickness = value passed by the size
  srli t1, t0, 1      # thickness / 2 .shifting the value by 1 just like dividing by 2
  sub a1, s1, t1      # y - (thickness/2) which is t1
  add a2, s2, s2      # size + size, to get double the size
  addi a2, a2, 1      # size^2 + 1
  mv a3, t0           # height = thickness
  mv a4, s3           # color
  call PlotBox

  # vertical arm: box at (x - thickness/2, y - size) with width = thickness, height = 2 * size + 1
  mv t0, s2            # thickness = value passed by the size
  srli t1, t0, 1      # thickness / 2 . shifting the value by 1 just like dividing by 2
  sub a0, s0, t1      # x - thickness/2
  sub a1, s1, s2      # y - size
  mv a2, t0           # width = thickness
  add a3, s2, s2      # size + size, to get double the size
  addi a3, a3, 1      # 2 * size + 1
  mv a4, s3           # color
  call PlotBox
#freeing the registers from the stack 
  lw ra, 0(sp)
  lw s0, 4(sp)
  lw s1, 8(sp)
  lw s2, 12(sp)
  lw s3, 16(sp)
  addi sp, sp, 20
  
end:
  ret