####### Definitions #######
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

.data #################### initialized data
# Sprite data for "packman"
packman:
    .byte 0b00111100
    .byte 0b01111110
    .byte 0b11001111
    .byte 0b11001100
    .byte 0b11110000
    .byte 0b11111111
    .byte 0b01111110
    .byte 0b00111100

# Sprite data for "ghost"
ghost:
    .byte 0b00111100
    .byte 0b01111110
    .byte 0b11011011
    .byte 0b11001001
    .byte 0b11111111
    .byte 0b11111111
    .byte 0b11111111
    .byte 0b01010101
 
    
.text ############################## code
 
   # Clear the screen with black
    li a0, COLOR_BLUE
    call FillScreen
    
LIMIT:
 

   # Draw Pac-Man at position (5, 10)
    li a0, 5            # posX
    li a1, 10           # posY
    la a2, packman      # address of Pac-Man sprite
    li a3, COLOR_YELLOW # color
    call PlotSprite8x8  # draw the Pac-Man
    
        # Draw Pac-Man at position (10, 10)
    li a0, 20            # posX
    li a1, 10           # posY
    la a2, ghost      # address of Pac-Man sprite
    li a3, COLOR_RED # color
    call PlotSprite8x8  # draw the Pac-Man
    
        # Draw Pac-Man at position (15, 10)
    li a0, 30            # posX
    li a1, 20           # posY
    la a2, ghost      # address of Pac-Man sprite
    li a3, COLOR_GREEN # color
    call PlotSprite8x8  # draw the Pac-Man
    
    # Optionally, draw ghost at a different position
     li a0, 20           # posX
     li a1, 10           # posY
     la a2, ghost        # address of ghost sprite
     li a3, COLOR_CYAN   # color
     call PlotSprite8x8  # draw the ghost
  
end:
    li a7, OSExit
    ecall
    
############################################
PlotSprite8x8:
    
    
    addi sp, sp, -32
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)

    mv s0, a0          # Original X (base X)
    mv s1, a1          # Original Y (base Y)
    mv s2, a2          # Pointer to sprite
    mv s3, a3          # Color

    li s5, 8           # Loop over 8 rows

LoopRow:
    lbu s4, 0(s2)      # Load one byte = one row of sprite
    addi s2, s2, 1     # Move to next byte (next row)

    li s6, 0           # Bit index = column index (0 to 7)

LoopBit:
    # Check if bit at position (7 - s6) is 1
    li t0, 7
    sub t0, t0, s6
    li t1, 1
    sll t1, t1, t0     # t1 = 1 << (7 - s6)
    and t2, s4, t1     # t2 = s4 & t1

    beqz t2, SkipPixel

    # Bit is 1 → Plot pixel
    add a0, s0, s6     # x = base X + column offset
    add a1, s1, zero   # y = current row
    mv  a2, s3         # color
    call PlotPixel

SkipPixel:
    addi s6, s6, 1
    li t3, 8
    blt s6, t3, LoopBit

    addi s1, s1, 1     # Move to next row (Y++)
    addi s5, s5, -1
    bgtz s5, LoopRow

    # Restore registers
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    addi sp, sp, 32
    ret

    
#######################################################################################
PlotPixel:
    # Inputs:
    # a0: x position
    # a1: y position
    # a2: color
    
    la   t0, LED_MATRIX_0_BASE
    li   t1, LED_MATRIX_0_WIDTH
    li   t2, LED_MATRIX_0_HEIGHT
    
    # Bounds checking
    bltz a0, EndPP       # Skip if x < 0
    bge  a0, t1, EndPP   # Skip if x >= WIDTH
    bltz a1, EndPP       # Skip if y < 0
    bge  a1, t2, EndPP   # Skip if y >= HEIGHT
    
    # Calculate address: pixel_offset = (y * WIDTH + x) * 4
    mul  t3, a1, t1      # t3 = y * WIDTH
    add  t3, t3, a0      # t3 = y * WIDTH + x
    slli t3, t3, 2       # t3 = (y * WIDTH + x) * 4
    add  t3, t0, t3      # t3 = base_address + offset
    
    sw   a2, 0(t3)       # Store color at calculated address
    
EndPP: 
    ret
                                                                                                                                                                                                                  
#######################################################################################
FillScreen:
    # Input:
    # a0: color to fill the screen with
    
    la   t0, LED_MATRIX_0_BASE
    li   t2, LED_MATRIX_0_SIZE
    
LoopFS:
    sw   a0, 0(t0)       # Store color at current address
    addi t0, t0, 4       # Move to next pixel
    addi t2, t2, -1      # Decrement counter
    bgtz t2, LoopFS      # Continue if not done
    
    ret