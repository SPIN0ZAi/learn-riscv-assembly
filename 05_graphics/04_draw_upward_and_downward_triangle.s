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

.text
main:
    li a4, COLOR_BLACK
    call FillScreen

    # Square (10x10) at center
    li a0, 0      # X = 20 - 5
    li a1, 9      # Y 
    li a2, 40      # Width
    li a3, 10      # Height
    li a4, COLOR_WHITE
    call PlotBox

    # Upward triangle above square
    li a0, 0      # center X
    li a1, 18     # Y start
    li a2, 40       # starting width
    li a3, 10     # height
    li a4, COLOR_GREEN
    call PlotBox

    # Downward triangle below square
    li a0, 0
    li a1, 0
    li a2, 28       # starts wide
    li a3, 1
    li a4, COLOR_RED
    call PlotRightIsoscelesTriangle



    li a7, OSExit
    ecall

#####################################################
PlotTriangle:
    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    
    mv s0, a0      # x (starting x)
    mv s1, a1      # y (starting y)
    mv s2, a2      # initial width
    mv s3, a3      # height
    mv s4, a4      # color

loopcolt:
    mv s5, s2      # width counter for the row

looprowt:
    mv a0, s0
    mv a1, s1
    mv a4, s4
    call PlotPixel
    addi s0, s0, 1
    addi s5, s5, -1
    bgtz s5, looprowt

    sub s0, s0, s2      # reset x to start of new row
    addi s0, s0, -1     # shift left to taper
    addi s2, s2, 2      # grow width

    addi s1, s1, 1      # move down
    addi s3, s3, -1
    bgtz s3, loopcolt

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28
    ret

#####################################################
PlotUpsideDownTriangle:
    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    
    mv s0, a0      # x (left edge of base)
    mv s1, a1      # y (starting y)
    mv s2, a2      # width (start wide)
    mv s3, a3      # height (how many rows)
    mv s4, a4      # color

loopColT:
    mv s5, s2      # reset width counter
loopRowT:
    mv a0, s0
    mv a1, s1
    mv a4, s4
    call PlotPixel
    addi s0, s0, 1
    addi s5, s5, -1
    bgtz s5, loopRowT

    #THE CHANGE WAS MADE HERE:
    sub s0, s0, s2     # reset x to start of next row
    addi s0, s0, 1     # shift right to taper
     # shift right to taper
    addi s2, s2, -2   # shrink width

    addi s1, s1, 1     # move down
    addi s3, s3, -1
    bgtz s3, loopColT

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28
    ret

#####################################################
PlotRightIsoscelesTriangle:
    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)    # x
    sw s1, 8(sp)    # y
    sw s2, 12(sp)   # total height
    sw s3, 16(sp)   # current width
    sw s4, 20(sp)   # color
    sw s5, 24(sp)   # loop var

    mv s0, a0       # x (left edge)
    mv s1, a1       # y (top)
    mv s2, a2       # height
    mv s3, a3       # initial width (usually 1)
    mv s4, a4       # color

    srli t1, s2, 1  # half height (for midpoint)
    li t2, 0        # row counter

loop_iso_right:
    mv s5, s3       # row width
    mv t0, s0       # starting x for this row

draw_row_iso:
    mv a0, t0
    mv a1, s1
    mv a4, s4
    call PlotPixel
    addi t0, t0, 1
    addi s5, s5, -1
    bgtz s5, draw_row_iso

    addi s1, s1, 1       # move to next row (down)
    addi t2, t2, 1       # increment row counter

    blt t2, t1, grow_iso     # if we're in the top half
    bge t2, s2, end_iso      # if we've drawn all rows
    j shrink_iso

grow_iso:
    addi s3, s3, 2       # increase width
    j loop_iso_right

shrink_iso:
    addi s3, s3, -2      # decrease width
    j loop_iso_right

end_iso:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28
    ret

#####################################################
PlotLeftTriangle:
    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)    # x
    sw s1, 8(sp)    # y
    sw s2, 12(sp)   # height
    sw s3, 16(sp)   # width (initial width, usually 1)
    sw s4, 20(sp)   # color
    sw s5, 24(sp)   # loop var

    mv s0, a0      # x (tip of triangle)
    mv s1, a1      # y (start row)
    mv s2, a2      # height
    mv s3, a3      # initial width (starts small)
    mv s4, a4      # color

loopcol_left:
    mv s5, s3      # current row width
    mv t0, s0      # starting x (tip)

looprow_left:
    mv a0, t0      # x
    mv a1, s1      # y
    mv a4, s4      # color
    call PlotPixel
    addi t0, t0, -1   # go left
    addi s5, s5, -1
    bgtz s5, looprow_left

    addi s1, s1, 1     # move to next row (down)
    addi s3, s3, 1     # increase width
    addi s2, s2, -1    # decrease height
    bgtz s2, loopcol_left

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28
    ret


#####################################################
PlotBox:
    addi sp sp -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    
    mv s0 a0
    mv s1 a1
    mv s2 a2
    mv s3 a3
    mv s4 a4
    
    loopcol:
    mv s5 s2
    looprow:
    mv a0 s0
    mv a1 s1
    mv a4 s4
    call PlotPixel
    addi s0 s0 1
    addi s5 s5 -1
    bgtz s5 looprow
    
    sub s0 s0 s2
    
    addi s1 s1 1
    addi s3 s3 -1
    bgtz s3 loopcol
    
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp 28
   
    ret
#####################################################
PlotPixel:
    #a0 - x, a1 - y, a2 - width, a3 - height
    la t3 LED_MATRIX_0_BASE
    li t4 LED_MATRIX_0_WIDTH
    #equation:(y * width + x) * 4
    mul t5 a1 t4
    add t5 t5 a0
    slli t5 t5 2
    add t3 t3 t5
    sw a4 0(t3)
    ret
#####################################################
FillScreen:
    la t0 LED_MATRIX_0_BASE
    li t1 LED_MATRIX_0_SIZE
    loopFS:
    sw a4 0(t0)
    addi t0 t0 1
    addi t1 t1 -1
    bgtz t1 loopFS
    ret
    