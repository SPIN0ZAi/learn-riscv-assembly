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

main:
    # Clear the screen with black
    li a0, COLOR_B
    call FillScreen
   
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
    # li a0, 20           # posX
    # li a1, 10           # posY
    # la a2, ghost        # address of ghost sprite
    # li a3, COLOR_CYAN   # color
    # call PlotSprite8x8  # draw the ghost

end:
    li a7, OSExit
    ecall

############################################
PlotSprite8x8:
    # INPUTS
    # a0: coord X of top left corner
    # a1: coord Y of top left corner
    # a2: pointer to sprite data
    # a3: pixel color

    addi sp, sp, -28     # make space on stack
    sw   ra, 0(sp)       # save return address
    sw   s0, 4(sp)
    sw   s1, 8(sp)
    sw   s2, 12(sp)
    sw   s3, 16(sp)
    sw   s4, 20(sp)
    sw   s5, 24(sp)

    mv   s0, a0          # s0 = posX
    mv   s1, a1          # s1 = posY
    mv   s4, a2          # s4 = pointer to sprite data
    mv   s5, a3          # s5 = color

    li   s3, 8           # size Y (loop counter for rows)

loopY:
    li   s2, 8           # size X (loop counter for columns)
    
loopX:
    lbu  t0, 0(s4)       # Load byte of sprite data
    addi t1, s2, -1      # Calculate bit position
    srl  t0, t0, t1      # Shift right to get the current bit (MSB first)
    andi t0, t0, 1       # Isolate the bit
    beqz t0, skipPixel   # If bit=0, skip pixel
    
    mv   a0, s0          # x position
    mv   a1, s1          # y position
    mv   a2, s5          # color
    call PlotPixel       # Plot the pixel
    
skipPixel:
    addi s0, s0, 1       # Move to next x position
    addi s2, s2, -1      # Decrement column counter
    bgtz s2, loopX       # Continue if we haven't finished the row
    
    addi s0, s0, -8      # Reset x position
    addi s1, s1, 1       # Move to next row
    addi s3, s3, -1      # Decrement row counter
    addi s4, s4, 1       # Move to next byte of sprite data
    
    bgtz s3, loopY       # Continue if we haven't finished all rows

    # Restore saved registers
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    lw   s1, 8(sp)
    lw   s2, 12(sp)
    lw   s3, 16(sp)
    lw   s4, 20(sp)
    lw   s5, 24(sp)
    addi sp, sp, 28      # Free space on stack

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